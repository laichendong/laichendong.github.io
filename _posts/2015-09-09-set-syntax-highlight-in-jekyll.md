---
layout: post
category: Programing
title: jekyll设置语法高亮
---

	2015年09月11日，重要更新：
	以下都是扯淡。现在jekyll已经原生支持语法高亮了。
	直接将代码放到 {% raw %} {% highlight language %} 和 {% endhighlight %} {% endraw %}之间就ok了。

-------


使用jekyll的人，我想大部分都应该经常和代码打交道吧。那代码高亮自然少不了，今天就讲讲如何在jekyll中配置代码高亮。

代码高亮的工具有很多。jekyll原生支持的是[pygments](http://pygments.org/).
使的博客上的代码高亮的原理是用pygments生成一个css文件供页面引用，然后用jekyll的pygments插件将博客源文件中的代码处理成能使用该css的html代码。最后在浏览器的渲染下，代码就亮起来了。


看名字就应该知道这pygments是一个python写的东西了。那就可以用[pip](https://pypi.python.org/pypi/pip)来安装了。

{% highlight sh %}
pip install Pygments
{% endhighlight %}

至于pip是什么，以及如何安装pip，就请自行google了。

安装完之后就应该用他来生成css文件了：

{% highlight sh %}
blogRoot $ pygmentize -S default -f html > css/pygments.css
{% endhighlight %}

这条命令的两个参数分别指定的是默认的配色方案和目标格式是html。关于参数解释和其他可选参数请看[官方文档](http://pygments.org/docs/cmdline/)

有了这个css文件，要生效当然要在页面里引用。对于我这偷懒的人来说，就直接放在*_includes/head.html*里了，这样做的好处和坏处都是每个页面都有这个css了。

{% highlight html %}
<link rel="stylesheet" href="{{ "/css/pygments.css" | prepend: site.baseurl }}">
{% endhighlight %}

现在css已经具备了。接下来要做的就是将页面上的代码转换成符合这个css的html了。我们先用gem安装pygment.rb

{% highlight sh %}
$ gem install pygments.rb
{% endhighlight %}

然后在配置文件*_config.yml*中添加一行，告诉jekyll用pygment来处理高亮。

{% highlight yaml %}
highlighter: pygments
{% endhighlight %}

我们在源文件中，将代码放到 {% raw %} {% highlight language %} 和 {% endhighlight %} {% endraw %}之间就ok了。 其中language支持那些以及怎么写依然可以参照[官网](http://pygments.org/docs/lexers/)。
如果官方提供的300多种语言都不够用的话，那你干脆自己写一个得了。反正pygments支持自定义。
到这，你的代码就应该亮起来了！

说句题外话。jekyll的口号是：什么都不用管，只用关心你的博客内容。我觉得就是扯淡。会自己搭博客的人。这应该是最烂的广告了。如果什么都没得折腾。那还用你干嘛。直接oschina上注册一个账号不是更好？
就是因为可以各种折腾，我才选用jekyll的。

# 生命不息，折腾不止。

