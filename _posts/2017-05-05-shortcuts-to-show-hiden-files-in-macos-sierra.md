---
layout: post
category: mac
title: 用快捷键在Finder里显示隐藏文件
---

在 macOS Sierra 之前，要在 Finder 中查看隐藏文件，都要输入一大坨命令：

``` shell
defaults write com.apple.finder AppleShowAllFiles -bool true
```

用完之后还要再输入一坨再隐藏起来，关键因为用的频率不高，所以每次要用之前还要把命令找出来，太过麻烦，以至于后面我都不用它看隐藏文件了，用`ls -a`反而更方便些。

**燃鹅**，现在不一样了。

在 macOS Sierra，我们可以使用快捷键`⌘⇧.`(`Command + Shift + .`) 来快速（在 Finder 中）显示和隐藏隐藏文件了。

简直不能更方便。