#! /bin/bash

## 发布博文到公网 

jekyll clean
jekyll b
git add .
if [[ $1 ]]; then
	git commit -a -m "$1"
else
	git commit -a
fi

git push