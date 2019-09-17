#! /bin/bash 

if [ $# != 1 ] ; then 
echo "USAGE: $0 file_name" 
echo " e.g.: $0 hello_world" 
exit 1; 
fi 

f=$1".md"
if [[ -f $f ]]; then
	echo "$f 已存在，请更换文件名"
fi
#touch $f
echo "---
layout: post
category: 读书笔记
tags: []
title: $1
---" > $f
open -a Typora $f