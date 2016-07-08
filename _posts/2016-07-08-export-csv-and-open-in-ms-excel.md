---
layout: post
category: 不好分类的
title: 导出的CSV在excel中打开乱码
---

在项目中经常会遇到需要到导出excel的场景，为了简化和兼容性，常常会变成“导出csv”。
这其中发现一个怪现象：**UTF-8编码的csv文件用excel打开会乱码，而GBK编码的不会。**
作为高端大气的应用，显然不希望生成个GBK编码的文件啊。（GBK在我mac下用sublime打开也会是乱码的）
在网上查到说excel是使用ANSI编码打开文件的。而ANSI在大陆就是GBK。so，貌似问题无解啊，就得用GBK！
后来继续google，发现如果excel打开的是带BOM的UTF-8文件的话，是不会有问题的。
于是，**生成文件时，加上UTF-8的BOM头**，搞定！

```java
file = new File(absolutePath);
fos = new FileOutputStream(file);
fos.write(new byte[]{(byte) 0xEF, (byte) 0xBB, (byte) 0xBF}); // 写U8 BOM 否则excel打开会乱码
fos.flush();
writer = new CSVWriter(new OutputStreamWriter(fos));
writer.writeAll(data);
writer.flush();
```

## 扩展阅读

1. ANSI编码
ANSI是美国国家标准学会（American National Standards Institute，ANSI）的缩写，他是国际标准化组织和国际电工委员会的成员。如果ANSI作为一种编码来说。不同的国家制定了不同的标准。
比如：中国大陆的GBK，台湾的BIG5等等，不同地区的标准还互不兼容！

2. [BOM头](https://zh.wikipedia.org/wiki/%E4%BD%8D%E5%85%83%E7%B5%84%E9%A0%86%E5%BA%8F%E8%A8%98%E8%99%9F)
BOM是字节顺序标记（byte-order mark）的缩写，如字面意思，他是用来标记文件里的字节的顺序的，告诉读文件的人如何解析。
UTF-8的BOM为`EF BB BF`, UTF-16 大端序的BOM为`FE FF`, 小端序为`FF FE`。
一些编辑器能直接显示文件编码，比如windows下的Notepad++，而我用的sublime Text 2 则需要额外安装插件：Show Encoding.