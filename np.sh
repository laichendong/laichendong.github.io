#! /bin/bash
if [[  ! -n "$1" ]]; then
	echo "usage： ./np.sh post-name [category-name]"
	exit -1
fi
file_name="_posts/"`date +%Y-%m-%d-`$1".md"
touch $file_name

echo "---" >> $file_name
echo "layout: post" >> $file_name
echo "category: $2" >> $file_name
echo "title: $1" >> $file_name
echo "---" >> $file_name

subl $file_name