---
layout: post
category: 
title: 在服务端将HTML转成图片
---

有一些场景，需要**将网页转换成图篇**。比如为了兼容性把网页图表生成截图随邮件发送，网页热力图的底图等等。

我想总不能搞个浏览器，将网页放进去然后截图吧。浏览器还不一定开放了这种接口呢。出于效率和规模的考虑，也不现实啊。

然后搜了一下。发现一些办法：

## 1. 使用awt或者swing
思路基本上是现在 AWT or Swing 的Panel上显示网页，在把Panel输出为 image 文件。java 本身的API有提供相关的结果，但是直接产生的效果不是很好

## 2. 使用h5的api，将网页画到canvas上
[html2canvas](http://html2canvas.hertzen.com/screenshots.html)就是这样的一个东西。但是兼容性不好，中文字体啦，处理懒加载啦，各种问题。

## 3. 使用类似phantomjs这样的东西
[phantomjs](http://phantomjs.org/)是一个没有界面的，提供了js API的WebKit。他很快，且原生支持各种web标准，比如Dom处理，CSS选择器等等。
使用phantomjs，首先要在服务器上安装phantomjs。然后用JNI调用本地命令和他交互就好了，就像imageMagic一样。
据官网介绍，他用来做页面的自动化测试也是非常棒的！
与他相似的还有[slimerjs](https://slimerjs.org/),只是他基于Gecko。

## 4. 还有一些其他的类库
[Html2Image](https://code.google.com/p/java-html2image/), [Cobra](http://lobobrowser.org/) 等等

