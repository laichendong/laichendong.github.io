# Sequence（唯一id） 生成器

在如今的分布式场景下，MySql分库分表非常常见。我们不能用MySql的auto increment字段，这是单表的。我们需要保证一个逻辑表的若干物理表里的数据的主键互相不重复。因为如果存在重复的情况，当物理表扩容或缩容导致数据移动并进一步导致两条拥有相同ID的数据进入到一张表里时，就会造成主键冲突。所以，我们需要一个全局的，高性能的唯一主键生成器。

GUID 或UUID 貌似就符合这个要求！但是，一来这类id不是数字的，生成不具有全局顺序性。二来，也是因为不是数字的，做MySql的主键，性能不如数字。所以，虽然生成的成本很低，也要放弃这个方案。

我们的方案是，在数据库中持久化一个数值，表示当前ID增长到了哪，要获取下一个ID时则带条件的去更新这个值为`当前值+1`（乐观锁），如果更新成功，则认为获取到了新的ID，如果不成功，则再试到成功为止。进一步的，为了在逻辑表和应用服务器都比较多的情况下，降低持有这个值的表过热，乐观锁碰撞过多的情况。允许每个应用服务器持有一个容量为n的ID块，然后n次内的ID获取在应用服务器内同步的完成，第n次获取，才向数据库发一次update操作，修改数据库从+1变成+n。大概示意图如下：

![](https://ws4.sinaimg.cn/large/006tKfTcly1fs1kchrygtj310l0tsjxt.jpg)

下面来详细看下实现

首先，由于上面提到的应用服务器内持有一个容量为n的id块，我们设计了一个内部类Step来实现这个功能。

``` java
static class Step {
        private long currentValue; // 当前值，调用incrementAndGet()返回下一个id
        private long endValue;  // 当前块的结束值，限定Step的容量

    	// 初始化时  endValue - currentValue = n   (blockSize)
        Step(long currentValue, long endValue) {
            this.currentValue = currentValue;
            this.endValue = endValue;
        }

        public void setCurrentValue(long currentValue) {
            this.currentValue = currentValue;
        }

        public void setEndValue(long endValue) {
            this.endValue = endValue;
        }
      
        // 因为这个方法 外面是在同步块里调用的，所以这里没用synchronize，
        // currentValue 也没用 AtomicLong
        public  long incrementAndGet() {
            return ++currentValue;
        }
    }
```

我们再看Sequence类：

``` java
public class Sequence {
    private int blockSize = 5; // 容量或者叫步长，一次从数据库中获取多少个ID
    private long startValue = 0; // id从几开始涨，在已有数据要迁移的情况下，可以设置为非零的数
    // 每个表一个Step，这个map持有了所有表的Step引用
    // 外面是同步的  所以也不用concurrentHashMap
    private Map<String,Step> stepMap = new HashMap<String, Step>();
    
    // 持有数据源和三条sql。用于持久化的表名是写死的：sequence_value
    // 数据源通过spring注入
    private DataSource dataSource;
    private final static String GET_SQL = "select id from sequence_value where name = ?";
    private final static String NEW_SQL = "insert into sequence_value (id,name) values (?,?)";
    // 这条sql里where条件里的id=?很重要，是一个乐观锁机制，防止过程中已经有别的进程(别的Sequence实例)
    // 对表进行了更新，导致id重复
    private final static String UPDATE_SQL = "update sequence_value set id = ?  where name = ? and id = ?";
    // ...
}
```

Sequence类的唯一入口方法 get的实现：

``` java
// 这个方法必须是同步的，防止多个线程同时获取同一表的id，导致重复
public synchronized long get(String sequenceName) {
        Step step = stepMap.get(sequenceName);
    	if(step == null) {
            // step == null 表示第一次获取这个表的id，后面的逻辑会继续走，从数据库中读入
            // 直接new一个Step放到map里备用，下次就能走else里的逻辑了
            step = new Step(startValue,startValue+blockSize);
            stepMap.put(sequenceName, step);
        } else {
            // 当前块还没用完，直接内存里返回下一个ID就好
            // 否则的话，表示当前块里id用完了，继续走下面的从数据库中获取的逻辑
            if (step.currentValue < step.endValue) {//默认为0和0，所以没有错
                return step.incrementAndGet();
            }
        }
    
        // 尝试blockSize次 从数据库获取下一个块
        for (int i = 0; i < blockSize; i++) {
            if (getNextBlock(sequenceName,step)) {
                //  一旦获取到，就直接内存里返回，不用再getNextBlock了
                return step.incrementAndGet();
            }
        }
    
        // 尝试了若干次都失败了，只能抛异常出去
        throw new RuntimeException("No more value.");
    }
```

我们再看看从数据库中获取下一个块的实现是怎么样的。其实从上面看到的3条sql基本上就已经了解得7788了。

``` java
private boolean getNextBlock(String sequenceName, Step step) {
    	// 发select语句，获取库里当前值
        Long value = getPersistenceValue(sequenceName);
        if (value == null) {
            try {
                // 如果没有，就初始化， 发insert语句，
                // insert的值是上面配置的 startValue, 默认为0， 返回的是刚插入的值
                value = newPersistenceValue(sequenceName); 
            } catch (Exception e) {
                // 如果初始化失败，说明有程序先初始化了，(别的进程也同时对这个表进行id获取)
                // 这里需要对sequence_value表的name字段做唯一索引限制。否则会有问题
                // 可能两个进程同时插入了两条name相同的数据
                log.error("newPersistenceValue error!");
                value = getPersistenceValue(sequenceName); 
            }
        }
        // 发update语句，申请下一个块，将库里的值update为 value+blockSize ，
        // 这样，这个进程里的请求就能直接内存返回
        // 而别的进程 去getNextBlock时，会改成更大的值，
        // 比如A进程持有的是 0-5， B进程持有的是 6-10
     	// 这条update语句是带条件更新的，前面已经有提到，也是为了防止并发产生id重复
        // 因为带条件更新可能失败， 所以 如果失败，外面的get方法要进行重试。 策略是重试blockSize次
        boolean b = saveValue(value,sequenceName) == 1;
        if (b) {
            // 成功获取到下一个块了，更新step对象，后面就可以用step.incrementAndGet()了。
            step.setCurrentValue(value);
            step.setEndValue(value+blockSize);
        }
        return b;
    }
```

到此，Sequence的核心实现就完成了。`getPersistenceValue` `newPersistenceValue`  `saveValue` 这三个jdbc操作数据库的方法没什么特别的，就不贴出来细看了。

有些时候，除了我们的主业务表比较大，id需求比较大，需要单独一个Sequence名字，其他很多小表可以共用一个默认的Sequence名字，所以，就又提供了一个`SequenceUtil`类。作为Sequence的一个代理，如果没有对应名字的id序列，就用默认的序列。

``` java
public class SequenceUtil {
	public long get(String name) {
        Sequence sequence = null;
        if (sequenceMap != null) {
            sequence = sequenceMap.get(name);
        }
        if (sequence == null) {
            // 如果从持有的map里没取到这个名字的Sequence的话，就取默认的
            if (defaultSequence != null) {
                return defaultSequence.get(name);
            } else {
                // 默认的还没有配置，就抛异常
                throw new RuntimeException("sequence " + name + " undefined!");
            }
        }
        // 代理到具体的Sequence实例 进行id的get
        return sequence.get(name);
    }
}
```



OK，到此为止这个精巧的设计就介绍完了。如果要生成id的表太多，导致Sequence_value表过热，可以把BlockSize调大一些，减少对库的操作次数。甚至可以设置几个不同的实例，连接不同的数据源。 这个设计有一个需要注意的地方，就是生成的id是大体上全局有序的，但不是严格有序的。比如A实例持有该1-5，B实例持有6-10。生成的id可能是`1，6，2，7……` 

都看到这了，说明是真爱！那就给个赠品吧。flickr的Ticket Server设计。这我们这个设计有许多相似之处。供参考：http://code.flickr.net/2010/02/08/ticket-servers-distributed-unique-primary-keys-on-the-cheap/