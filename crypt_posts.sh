#! /bin/bash
md_file_names=`grep -r "crypt: true" ./_posts | awk -F / '{printf $3"\n"}' | awk -F ".md" '{printf $1"\n"}' | cut -c 12-`
for i in $md_file_names; do
	html_file=`find ./_site -name $i | xargs -I {} find {} -name "*.html"`
	staticrypt $html_file  123 -o ./s/$i.html
	echo "$html_file crypted to ./s/$i.html"
done