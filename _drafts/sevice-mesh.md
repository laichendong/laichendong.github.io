### **一、什么是service mesh**

Service Mesh作为下一代微服务技术的代名词，是云原生与Serverless的关键技术， 最近两年非常火。**有个通俗的比喻：Service Mesh是微服务时代的TCP/IP协议。**

最早是开发 linkerd 的公司的CEO **WILLIAM MORGAN** 在2017年4月提出的。https://buoyant.io/2017/04/25/whats-a-service-mesh-and-why-do-i-need-one/

这篇文章介绍了linkerd的一些功能：服务注册与发现，服务间通讯，负载均衡，限流，熔断 等等。并且第一次提出了service mesh的概念。也就是说service mesh的核心功能就是这些。

### **二、为什么叫mesh（网格）**

另外一篇著名的文章，https://philcalcado.com/2017/08/03/pattern_service_mesh.html 讲了一下两个服务进行通讯的发展阶段，非常形象的说明了原因。

第一阶段：草莽，应用自己要做网络拆包，重拍，流控 各种“底层”

![img](https://pic4.zhimg.com/80/v2-1443e6bebd93d5e6bb1c18197676d29b_1440w.jpg)

第二阶段：TCP阶段：网络底层有封装了，甚至有netty这样的工具了

![img](https://pic2.zhimg.com/80/v2-9e6c4c6b4229b947b4efdf63de86f695_1440w.jpg)

第三阶段：RPC阶段，soa化，应用自己做服务发现，限流等等， wsdl， hession

![img](https://pic1.zhimg.com/80/v2-b31cc447637c71b887ac80c0bfa680d4_1440w.jpg)

第四阶段：微服务阶段，服务治理相关封装到了独立的包里，但还和应用跑在同一个容器里    jsf   spring cloud

![img](https://pic1.zhimg.com/80/v2-9382bf9facb290eceed01d998ac2ef44_1440w.jpg)

第五阶段：service mesh阶段，边车模式（sidecar） ，一个pod，两个container，服务治理被下沉到了基础设施层，和应用分离。

![img](https://pic3.zhimg.com/80/v2-546ed82e25d83a2cb404b0a3f526f9c6_1440w.jpg)

从宏观视角看，服务调用，就组成了一个网格状（mesh），所以叫service mesh。

![img](https://pic4.zhimg.com/80/v2-8a9cc161a34d97f36ead06d0abc5b1fb_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-8686840abd3de29e5cb6e8dcfa78182f_1440w.jpg)

### 三、主流的service mesh框架

linkerd：最老牌，完善的service mesh框架

Istio：google，IBM等牵头搞的，目前很受欢迎，几乎是事实上的标准

SOFA：蚂蚁金服搞的，基于Istio思路，性能更好一些

京东也在搞

### 四、相比微服务框架的优势

- Service mesh并没有解决新问题，只是换了一种新的方式解决原来解决得不太好的问题。
- side car对服务来说，是一个透明的本地代理。老旧系统几乎不用改动就能上云。
- side car可以独立升级，比如这次的fast-json问题 就能更好的解决。现在还有人用jsf 1.x的人~