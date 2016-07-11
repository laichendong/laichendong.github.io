#! /bin/bash

## 发布博文到公网 

jekyll clean
jekyll b
git add .
git commit -a