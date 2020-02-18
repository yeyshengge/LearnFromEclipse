<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>导航栏</title>	
	<meta charset="utf-8" />
</head>
<body>
	<div style="margin-top: -16px">
	<div style="width: 100%;
	height: 60px;
	line-height: 60px;
	background-color: #3F3F3F;" align="center">
	<div >
		<ul>
			<li style="width: 180px;
			height: 60px;
			list-style-type:none;
			float: left;"><img src="img/logo3.png" style="width: 160px;height: 60px"></li>
			
			<li id="test2" style="width: 80px;
			list-style-type:none;
			float: left;color:white;" >职培平台</li>

<!-- <script type="text/javascript">
  var oDiv=document.getElementById('test2');
  oDiv.onmouseout=function(){
    this.style.background='#3F3F3F';
    this.style.color='white';
  };
  oDiv.onmouseover=function(){
    this.style.background='#3F3F3F';
    this.style.color='#38B0DE';
  };
</script> -->

<li id="test" style="width: 80px;
list-style-type:none;
float: left;color:white" >首页</li>

<script type="text/javascript">
	var oDiv=document.getElementById('test');
	oDiv.onmouseout=function(){
		this.style.background='#3F3F3F';
		this.style.color='white';
	};
	oDiv.onmouseover=function(){
		this.style.background='#3F3F3F';
		this.style.color='#38B0DE';
	};
</script>

<li id="test1" style="width: 80px;
list-style-type:none;
float: left;color:white" >课程</li>

<script type="text/javascript">
	var oDiv=document.getElementById('test1');
	oDiv.onmouseout=function(){
		this.style.background='#3F3F3F';
		this.style.color='white';
	};
	oDiv.onmouseover=function(){
		this.style.background='#3F3F3F';
		this.style.color='#38B0DE';
	};
</script>

</ul>
</div>
<div style="position: absolute;left: 1200px">
	<ul style="margin-top: 0">
		<li style="width: 80px;
		list-style-type:none;
		float: right;color:white" >登陆/注册</li>
		
		<li style="width: 80px;
		height: 60px;
		list-style-type:none;
		float: right;"><a href="信息中心.html"><img style="width: 30px;margin-top: 15px" src="img/u1246.png"></a></li>
		<li  id="test4" style="width: 80px;
		list-style-type:none;
		float: right;color:white" >个人中心</li>

		<script type="text/javascript">
			var oDiv=document.getElementById('test4');
			oDiv.onmouseout=function(){
				this.style.background='#3F3F3F';
				this.style.color='white';
			};
			oDiv.onmouseover=function(){
				this.style.background='#3F3F3F';
				this.style.color='#38B0DE';
			};
		</script>
	</ul>
</div>
<div>
	<form style="position: absolute;left:700px">
		<input type="text" placeholder="请输入搜索内容" name="输入搜索内容" style="width: 200px;height: 28px;border-color: #108EE9;border-top-left-radius: 5px;border:0px;border-bottom-left-radius: 5px"><button type="submit" style="height: 29px;width: 50px;background-color: #108EE9;margin-top:1px;border: 0px;border-top-right-radius: 5px;border-bottom-right-radius: 5px;color: white">搜 索</button>
	</form>
</div>
</div>
</div>
<div style="width:100%;height: 200px;background-color: #999999">
	<div><img style="width:150px;height: 150px;margin-top: 20px;margin-left: 20px" src="img/u7383.png"></div>
	<div >
		<ul style="position: absolute;left:200px;top: 100px;list-style-type:none;">
		<li><span><h2>用户名</h2></span></li>
        <li><span>已加入班级 ： 1个</span></li>
	    <li><span>收藏课程 ： 1个</span></li>
        </ul>
	</div>
	<div style="position: absolute;right: 50px"><a href="忘记密码－手机账号.html">修改密码</a></div>
</div>
<div>
	<h2 style="margin-left: 50px">我的收藏</h2>
</div>
  <div style="width:1150px;height: 200px;background-color: #F4F4F4;margin-left: 200px;margin-top: 50px">
  	<img style="width:200px;height: 200px" src="img/1.PNG">

  	<h3 style="margin-left: 300px;margin-top: -160px;height: 150px;width:650px">这是一本神奇的书各层次框架的市场演进（MVC，持久层，前端）
                   arrayList（查询快，增删慢）,LinkedList（查询慢，增删快）,Vector（都快）相关知识
                   Set添加数组没有重复的（验证）Vector三种构造方法。
                   jdbc自定框架设计及实现思路
                   jdbc的连接与关闭</h3>
  		<h2 style="margin-top: -200px;margin-left: 300px">《java从入门到放弃》</h2>
  		<a style="margin-left: 1000px;text-decoration: none;" href=#">删除</a>
  		<a style="margin-left: 1000px;text-decoration: none;" href=#">查看</a>
  </div>


<div style="width:1150px;height: 200px;background-color: #F4F4F4;margin-left: 200px;margin-top: 50px">
  	<img style="width:200px;height: 200px" src="img/1.PNG">

  	<h3 style="margin-left: 300px;margin-top: -160px;height: 150px;width:650px">课程介绍</h3>
  		<h2 style="margin-top: -200px;margin-left: 300px">课程名</h2>
  		<a style="margin-left: 1000px;text-decoration: none;" href=#">删除</a>
  		<a style="margin-left: 1000px;text-decoration: none;" href=#">查看</a>
  </div>

  <div style="width:1150px;height: 200px;background-color: #F4F4F4;margin-left: 200px;margin-top: 50px">
  	<img style="width:200px;height: 200px" src="img/1.PNG">

  	<h3 style="margin-left: 300px;margin-top: -160px;height: 150px;width:650px">课程介绍</h3>
  		<h2 style="margin-top: -200px;margin-left: 300px">课程名</h2>
  		<a style="margin-left: 1000px;text-decoration: none;" href=#">删除</a>
  		<a style="margin-left: 1000px;text-decoration: none;" href=#">查看</a>
  </div>
	</body>
</html>