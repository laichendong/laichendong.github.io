---
layout: post
category: Programing
tags: [tensorflow, rosetta, m1, m2]
title: 如何在Apple芯片的mac上安装tensorflow 1.x

---

有时候我们需要再mac上跑一些老的用tensorflow 1.x的代码。但由于历史发展原因，各种依赖的版本无法对齐。无法直接安装，参考以下步骤。

以tensorflow 1.15为例。 tensorflow 1.15 要求 python 3.7。而python 3.7时期还没有m芯片。所以不能直接conda install python==3.7 安装。需要先安装罗塞塔（rosetta 2），来支持Intel芯片的程序

``` shell
softwareupdate --install-rosetta --agree-to-license
```

然后用conda安装python 3.7

``` shell
## 创建一个空环境
conda create -n tf1

## 激活
conda activate tf1

## 设置使用 x86_64 架构的通道
conda config --env --set subdir osx-64

## 正常安装 python, 其他包同理
conda install python==3.7 
```

安装tensorflow

``` shell
conda install -c apple tensorflow==1.15
```

到这基本就完成了，但可能还会遇到一些包版本不匹配的情况，自己再手动安装对应正确的版本就好了。比如

1、ImportError: cannot import name 'trace' 

是因为conda安装tf1.15时，其中tensorflow-estimator库的版本可能不正确，可以手动重新安装该库

``` shell
conda install tensorflow-estimator==1.15.1
```

2、numpy版本过高

``` shell
conda install numpy==1.16.5
```



​	