---
layout: post
category: Programing
title: 用jekyll和github pages写博客
---

题外话，在当今这个微博都还没来得及高兴一下就被朋友圈拉下神坛的年代，说如何搭建自己的博客系统似乎已经太过于过时了。
如果你有这样的想法，恐怕这篇文章不是非常适合你了。建议你把它关了去刷朋友圈。如果你和我一样，还是愿意折腾，并且愿意将折腾记录下来。那么，我们交个朋友吧。一起去刷朋友圈。

工欲善其事，必先利其器。介绍一下我们要用到的两个工具。
首先登场的是：[github pages](https://pages.github.com/)是*github*提供的，免费的，类似于网页空间，一样的一种服务，每个账号和每个项目都可以对应一个pages站点。
今天的另一个主角叫[jekyll](http://jekyllrb.com/)是一个用ruby写的，开源在github上的将纯文本文件转换成静态博客网站的一个工具。

其实，有了github pages你就完全可以想怎么玩就怎么玩了。因为他就是一个网页空间。将html文件扔上去就行了。下面我们一步一步看如何配置你的github pages。我们要做的是个人博客，当然是账号级别的比较好。

第一步，当然是要在github里建立一个仓库。注意：这个仓库的名字特别重要，需要这种格式：*你的用户名.github.io*， 比如我，就是laichendong.github.io

第二步，将这个仓库克隆到本地。

	~ $ git clone https://github.com/username/username.github.io

第三步，写一个hello world到你的博客里。

	~ $ cd username.github.io
	~ $ echo "Hello World" > index.html

第四步，提交，推到远端。

{% highlight sh %}
~ $ git add --all
~ $ git commit -m "Initial commit"
~ $ git push -u origin master
{% endhighlight %}

第五步，没有第五步了。浏览器里访问一下：http://username.github.io

到这里，你已经拥有了一个你自己的博客站点。想写什么就写什么了！但是，开什么玩笑！我来是想些博客的。不是想来做网站的！这个时候就该jekyll上场了。

第一步，安装jekyll
	
	~ $ gem install jekyll

很悲催的是，国内的网络环境可能导致你在这一步就失败了。于是，我们求助于万能的淘宝，[http://ruby.taobao.org/](http://ruby.taobao.org/)是淘宝搭建的ruby gems镜像。感谢！
换源：
	
	~ $ gem sources --remove https://rubygems.org/
	~ $ gem sources -a https://ruby.taobao.org/
	~ $ gem sources -l
		*** CURRENT SOURCES ***
		https://ruby.taobao.org

这时候再运行安装命令应该就没问题了。

第二步，新建一个博客
	
	~ $ jekyll new myblog

第三步，运行博客服务器

	~ $ cd myblog
	~/myblog $ jekyll serve

这时候你你再浏览器里敲[http://localhost:4000](http://localhost:4000)就能看到效果了。

虽然在浏览器里你看到了一个页面，但你可能还有点蒙。我们回到myblog文件夹里看看，都是怎么回事儿。文件夹里的目录大概应该像这样，不完全一样也别大惊小怪。都是些一看就懂的东西 

	.
	├── _config.yml // 博客配置文件
	├── _drafts // 博客草稿
	|   ├── begin-with-the-crazy-ideas.textile
	|   └── on-simplicity-in-technology.markdown
	├── _includes // 包含文件，公共头尾什么的
	|   ├── footer.html
	|   └── header.html
	├── _layouts // 布局文件，用来组装页面架子的
	|   ├── default.html
	|   └── post.html
	├── _posts // 你的博客原文
	|   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
	|   └── 2009-04-26-barcamp-boston-4-roundup.textile
	├── _site // 最终生成的博客站点
	├── .jekyll-metadata // jekyll自己用的一些元数据，最好别把它放到git里区管理
	└── index.html // 这个你懂的拉

假如你新写了一篇文章在*_posts*里。先运行一下build在server就能看到了。
	
	~ $ jekyll build
	~ $ jekyll s

你不会想问我，怎么将jekyll生成的网站弄到github pages上去吧？额，很简单。把**整个目录** 注意是整个目录，包括源文件配置文件等等，都扔到你的username.github.io这个仓库里去就行了。github pages能自动识别出来 _site 下才是你的站点。真是太tmd贴心了！

如果你看到这了都还没放弃，说明我们已经是朋友了。
就再说两招吧：

一，没事儿多看官网的文档。这才是王道。英文头疼的话，jekyll还有好心人翻译了中文的：[http://jekyllcn.com/](http://jekyllcn.com/)

二，如果你像我一样，有自己的域名，切不喜欢github.io的二级域名的话，也可以配置解析，让github pages用自己的域名

第一步是在你的仓库里建立一个*CNAME*文件。这个文件里就写你的域名就行了，比如*laichendong.com*，别有别的了。如果正确设置了CNAME文件，在你的仓库设置页面，应该能看到这样一行字。

	 Your site is published at http://laichendong.com

第二步就是将你的域名解析指向到你的github给你的二级域名上就ok了。

**器已经善了，工才是王道。博客已经搭建起来了，里面的博文才是最重要的。愿你记录非凡人生。**



