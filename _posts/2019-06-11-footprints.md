---
layout: post
title: 足迹地图
category: 生活

---



<div id="main" style="height:40em;"></div>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/echarts/4.2.1/echarts.min.js"></script>
<script type="text/javascript" src="/js/china.js"></script>
<script type="text/javascript">
window.onload=function(){
	var mydata = [
		{name: '北京',value: 1 },{name: '天津',value: 1 },
	{name: '上海',value: 1 },{name: '重庆',value: 1 },
	{name: '河北',value: 1 },{name: '河南',value: 10 },
	{name: '云南',value: 10 },{name: '辽宁',value: 10 },
	{name: '黑龙江',value: 10 },{name: '湖南',value: 10 },
	{name: '安徽',value: 10 },{name: '山东',value: 1 },
	{name: '新疆',value: 10 },{name: '江苏',value: 1 },
	{name: '浙江',value: 1 },{name: '江西',value: 1 },
	{name: '湖北',value: 1 },{name: '广西',value: 10 },
	{name: '甘肃',value: 1 },{name: '山西',value: 10 },
	{name: '内蒙古',value: 1 },{name: '陕西',value: 1 },
	{name: '吉林',value: 10 },{name: '福建',value: 1 },
	{name: '贵州',value: 10 },{name: '广东',value: 1 },
	{name: '青海',value: 1 },{name: '西藏',value: 10 },
	{name: '四川',value: 1 },{name: '宁夏',value: 10 },
	{name: '海南',value: 1 },{name: '台湾',value: 10 },
	{name: '香港',value: 10 },{name: '澳门',value: 10 }
	];
var option = {
		visualMap: {
			show : false,
			splitList: [ 
				{start: 5, end:10},{start: 1, end: 2}
			],
			color: ['#ccc', '#0f0']
		},
		series: [{
		  type: 'map',
		  mapType: 'china', 
		  label: {
		  	show:true
		  },
		  data:mydata
		}]
	};
var chart = echarts.init(document.getElementById('main'));
chart.setOption(option);
}
</script>



