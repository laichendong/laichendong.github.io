---
layout: post
category: python
title: 慕课网分析
subtitle: Python作业
tagline: 东东学python阶段性作业
---

学习能力应该是现代人最重要的一种能力没有之一了。而现在基于互联网的在线学习正方兴未艾。前两年，达内、传智播客这些培训机构基本上是干掉了计算机的本科教育。很多本科毕业的学生在找到“码农”工作之前都要去这些培训机构回一次炉。而通过这些机构速成出来的学生，就像练了“21天学会XXX”宝典一样。如果自身的再次学习能力不强，很容易沦为“搬砖汉”。而近几年，随着互联网的发展，各种在线教育网站层出不穷。内容创业或者说知识创业的人也很多。而慕课网就是这其中一家。

我学Python也是在网上自学。在慕课网上看了些教程，也就直接用他来练手了。现在交下作业^_^

目前慕课网上的课程涉及到前端，后端，设计，运维等8个方向。最热（课程数最多）的当然是前端，后端和移动三个了。云计算&大数据虽然也很热，但课程数方面，较之移动开发还是差了一大截。

<iframe width="100%" height="580" src="//jsfiddle.net/laichendong/24qLm0sw/13/embedded/result/" frameborder="0"></iframe>

再细化到具体技术来看，最先映入眼球的居然是Android。像PHP也占据了很大的一片空间，国内哪些比较大的公司还在大面积的使用PHP？

<iframe width="100%" height="580" src="//jsfiddle.net/laichendong/sc6cbgbn/embedded/result/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

同样是具体的技术，从学习者的角度看，情况发生了一些有意思的小变化，并不是课程多的学习者就一定多。像前端工具，设计工具，Html5，css3等学习者的数量和课程的数量都形成了比较大的反差。这似乎在说，前端的技术，比你想象的还热！

<iframe width="100%" height="580" src="//jsfiddle.net/laichendong/qLwhprqj/embedded/result/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

最后，我们来关心一下技术方向，课程数量，难度，学习人数和评分这几个指标的关系如何。首先绝大部分的课程学习人数都在20W或更少以下，学习人数最多的两个课程分别是属于前端的《HTML + CSS基础课程》和属于后端开发的《Java入门第一季》。其次是难度，入门课程数量较多，学习的人数也较多。最后是评分，这玩意儿在慕课显然也是没玩太好，大多课程的评分相差都不大，因为每个圆圈的面积都差不多。

<iframe width="100%" height="580" src="//jsfiddle.net/laichendong/gvaLa6o3/embedded/result/" allowfullscreen="allowfullscreen" frameborder="0"></iframe>

---

现在再来说实现就比较简单了。首先是写个爬虫，依次访问课程详情页把数据爬回来存成文件。然后再写个脚本把抓回来的数据进行汇总计算。最终把计算结果用echarts这样的图表可视化出来。

在实现过程中学习到两个小技巧：

1. 现在很多页面都是js加载数据的，靠原来直接访问URL再直接从response的html里提取数据的做法已经不行了。通常的做法是使用selenium驱动一个浏览器，让这个浏览器去访问要抓取的url。回来的response也在浏览器里实际运行。等数据都load回来了之后后再从浏览器里获得想要的数据。本例中我直接使用的是chrome。在速度和资源要求更高的场景里，可以使用PhantomJs这种“无界面的浏览器”来替代chrome。也可以加上多线程，多进程抓取等等。这是一个合格的爬虫应有的素质。
2. 在将分析结果输出成图表的过程中，觉得如果这就用个模板引擎的话，有点牛刀杀鸡的味道了。于是就直接用了`''.format()`应急。但是模板里有js代码，js代码里有`{`和`}`,转义啊简直是噩梦！然后，机制的我就把所有带大括号的js代码都挪到外部js文件里，然后引入了。效果杠杠滴，机制如我啊^_^  