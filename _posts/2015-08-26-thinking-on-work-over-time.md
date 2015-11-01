---
layout: post
category: 不好分类的
title: 加班记
---

故事还得从一个需求说起。
某一天，运营提出一个需求要对某些商家下的所有商品打上某一个特殊标识用于做某个维度的销量统计。
今天，线上出现了一些价格极低的商品，被下了很多订单。出事故了！
这两者之间有什么关联？对，这两者之间并没什么卵关系。

## 一
**关于批量处理数据。**我想这是一个不能避免的东西。在业务的发展过程中肯定会存在对历史数据的批量处理，迁移甚至是处理+迁移的需要。
如果是一个小得系统。就是一个数据库+上面几个页面展示。那好说。基本上是一条sql搞定的事情。但是随着系统越来越复杂，数据通常异构的存在不同的地方：DB，索引，缓存，还有下游系统。。。中。
这时一条sql显然就搞不定这事儿了。需要一个脚本（程序）来完成一系列的动作，才能保证整个系统的各个数据源保持一致。而要正确写出这个程序的人必须完全理解整个系统中这些数据的存储方式和计算逻辑。。。。mission impossible！
还要有模块化！一般某个数据源有横向的切面接口或某个业务有纵向的业务接口。这时候写这个脚本的人要做的就仅仅是理解并组合这些接口了。
这里有几个难点，一，这些接口要能被理解。这主要依赖于业务语义清晰。二，这些接口行为要正确，这主要依赖于接口的实现者理解接口的定义并正确的实现以及单元测试。

## 二
**关于事故。**当事故已经发生了。那唯一能做的就是消除影响，查找原因和修复故障。注意，这三者是有顺序的。首先得用最快的速度消除影响至少不让影响扩大。比如这个例子中可以让商品下架。然后再查找愿意，只有知道了原因，才能正确修复故障。
找原因时一定要避免变成问责，那是后面的事儿。找原因时一定要避免变成问责，那是后面的事儿。找原因时一定要避免变成问责，那是后面的事儿。重要的事儿说三遍。有必要的话，还可以做个复盘反思。同样，反思一定要避免问责。反思一定要避免问责。反思一定要避免问责。
当事儿都解决了。如果需要的话，那就问责吧。责任一定在leader，而不在具体的执行者。责任一定在leader，而不在具体的执行者。责任一定在leader，而不在具体的执行者。
当然，最重要的，最重要的，最重要的是在事故发生前的所有时刻的工作中如何尽可能的降低事故发生的概率。（事故永远可能发生）

## 三
**关于推倒重来。**不要推到重来！不要推到重来！不要推到重来！不论你对已有的系统是多么的看不上，不论已有的系统看上去或实际上是多么的一坨屎。都应该调整他，而不是推倒重来。因为推倒重来只可以解决一些你已经看到的问题。但。。。不说了，都是泪。不要推倒重来，到重来，重来，来。