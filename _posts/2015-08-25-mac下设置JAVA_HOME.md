---
layout: post
category: mac
---

应该是我装了xcode的原因，我没有显式安装java，mac里也有java的环境了。然后当我想在命令行下运行mvn的命令时。就提示我要设置JAVA_HOME了。
当我去找JAVA_HOME在哪的时候。发现是“乱七八糟”的。高冷的mac怎么会那么烂？我肯定是错过了什么。于是求助于万能的google。果然：
可以这样 

	export JAVA_HOME="$(/usr/libexec/java_home)"
	
甚至可以指定版本：
	
	export JAVA_HOME="$(/usr/libexec/java_home -v 1.6)"
	export JAVA_HOME="$(/usr/libexec/java_home -v 1.7)"
	export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"

牛了逼的。果然高冷！