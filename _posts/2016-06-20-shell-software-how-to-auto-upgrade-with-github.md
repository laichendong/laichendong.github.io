---
layout: post
category: 不好分类的
title: zsh等shell软件如何通过github实现自动更新功能
---

我的shell装了[zsh](https://github.com/robbyrussell/oh-my-zsh),不用说，这是一个很棒的shell增强软件。注意到他和其他一些基于github的软件一样，貌似直接把github当成更新服务器了。这让我觉得很cool啊。就看了下大概是怎么实现的。


# 1、如何检测更新
要自动更新自然就要先能检测到软件有更新。如果自动升级选项开启的话，zsh会首先执行`$ZSH/tools/check_for_upgrade.sh`文件来检查是否有更新。
zsh会用`~/.zsh-update`来存储最近一次更新的日期，如果当前日期和上次更新的日期差了一定天数（默认13天）则会提示为你是否要更新，不管选择是或否 都会更新`~/.zsh-update`文件的内容。如果具备其他的更新条件，比如有文件夹的鞋权限，比如git命令可用等等就具体执行更新动作了。

# 2、执行更新
具体的更新动作是通过`$ZSH/tools/upgrade.sh`完成的。看了下这个文件，so easy！ 大部分都是用来设置输出格式的。核心的就只有一句：`git pull --rebase --stat origin master` ok，这就将要更新的东西更新下来了。


# 3、扩展知识点
在看zsh实现的过程中，做为一个shell门外的菜鸟，了解到了如下一些知识点：

1、 `$EPOCHSECONDS`显示当前epoch时间（从1970年1月1日 0点到现在的时间）的秒数，这是一个内置环境变量？

2、 `[]`和`[[]]`。代码中大量看到这两种结构，单中括号是shell的内部命令，和`test`等同，可以用一些参数表示不同的测试功能，比如`-f`测试文件是否存在，`-w`测试文件是否可写，`-z`测试字符串是否为空等等，更多参考[随便找的一篇文章](http://blog.csdn.net/king_on/article/details/7281341).而双中括号是shell里的关键字，比前者更加通用，括起来的字符会发生“参数扩展”和“命令替换”——这句没看懂~

3、用`whence`命令检查软件是否安装。whence xxx将显示xxx命令的路径或者别名定义。 如果一个命令的路径是 `/dev/null` 那说明这个命令没有被正确安装，不可用！比如：`whence git >/dev/null || return 0`

4、`tput`他可以控制终端的光标文本等。zsh绚丽的终端界面就是用的这玩意儿，比如`RED="$(tput setaf 1)"  NORMAL="$(tput sgr0)"`然后`${RED}我是红的${NORMAL}我又正常了`，其他功能介绍看[这里](http://blog.csdn.net/l1905/article/details/8994705)

5、在命令行画画！相信很多人都见过纯文本的流程图，字符画什么的，觉得很cool。zsh也用了。我找了找，赠送两个装B网站：[asciiflow](http://asciiflow.com/) AND  [Asciio](http://search.cpan.org/dist/App-Asciio/lib/App/Asciio.pm)

