---
layout: page
title: 类目索引
---

<pre class="html" name="colorcode"> {% for post in site.categories.[page.category] %} {{ post.date }} {{ post.title }} {% endfor %} </pre>
