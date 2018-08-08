#!/usr/bin/env bash
work_dir=`pwd`

if [[ ! ${work_dir: -8} == "/_drafts" ]]; then
	echo "请把脚本放到_drafts目录下执行"
	exit 0
fi

if [[ $# != 1 ]]; then
	echo "请输入要发布的草稿文件名"
else
	f=$1
fi

if [[ ! -f "$f" ]]; then
	echo "文件不存在"
else
	fn=`date +%Y-%m-%d`-$f
	mv $f "../_posts/$fn"
	ls -l ../_posts/$fn
fi
