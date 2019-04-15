#!/usr/bin/env bash
work_dir=`pwd`
if [[ $1 -eq "-h"  ]]; then
	echo "useage: ./deploy.sh {draft_file_name}"
	exit 0
fi

if [[ ! ${work_dir: -8} == "/_drafts" ]]; then
	echo "请把脚本放到_drafts目录下执行 useage: ./deploy.sh {draft_file_name}"
	exit 0
fi

if [[ $# != 1 ]]; then
	echo "请输入要发布的草稿文件名 useage: ./deploy.sh {draft_file_name}"
else
	f=$1
fi

if [[ ! -f "$f" ]]; then
	echo "文件不存在"
else
	fn=`date +%Y-%m-%d`-$f
	mv $f "../_posts/$fn"
	echo "文件已发布到:" `ls -l ../_posts/$fn`
	
fi
