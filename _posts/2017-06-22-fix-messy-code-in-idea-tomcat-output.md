---
layout: post
category: 研发手记
title: 解决 IntelliJ IDEA Tomcat 控制台中文输出乱码问题
---

先说办法，再说原理！

# 办法

修改tomcat启动脚本：catalina.sh文件，找到`JAVA_OPTS` 增加文件编码参数：

```shell
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8"
```

就ok了。

或者，在idea启动tomcat时，设置这个参数：

![](https://ws2.sinaimg.cn/large/006tNc79ly1fgu0dj6siwj31kw0rrwh9.jpg)



# 原理

Idea控制台里的日志默认是从tomcat的localhost.log 和 catalina.log 两个文件读出来的。

![](https://ws1.sinaimg.cn/large/006tNc79ly1fgu03qo44gj31820ngdh0.jpg)

一般，我们的IDEA配置的编码是UTF-8.

![](https://ws3.sinaimg.cn/large/006tNc79ly1fgu06blyblj318e10qjtz.jpg)

如果tomcat输出的catalina日志文件不是UTF-8的，在console里看，就会出现乱码的情况，所以，应该将tomcat生成文件的编码改了。

# 扩展

## idea启动的tomcat生成的catalina.log文件在哪呢？

在console中观察启动日志，其中一个参数叫 `CATALINA_BASE` 这个地址就是了。

![](https://ws4.sinaimg.cn/large/006tNc79ly1fgu0h1snp7j318q0m243s.jpg)

找到下面的logs目录，文件就躺在那。看一下修改前和修改后，生成的问题编码有什么不同：

![](https://ws1.sinaimg.cn/large/006tNc79ly1fgu0isa29tj30o005qaap.jpg)

