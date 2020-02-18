<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
<form class="login-box">
		<h1>登录</h1>
		<div class="textbox">
			<i class="fa fa-user" aria-hidden="true"></i>
			<input type="text" placeholder="用户账号" 
			 id="userid" onblur="checkid()">
		</div>
		<div id="idalert"></div>
		<div class="textbox">
			<i class="fa fa-lock" aria-hidden="true"></i>
			<input type="password" placeholder="密码" 
			 id="userpaw" onblur="checkpwd()">
		</div>
		<div>
			<input type="radio" name="user" checked="checked">学员登录
			<input type="radio" name="user">管理员登录
		</div>
		<div id="pwdalert"></div>
		<a href="首页.html"><input class="btn" type="submit" value="登录"></a>
		<p>还没有账号？<a href="regist.html">点击注册</a></p>
	</form>
</body>

<script type="text/javascript">
	function checkid(){
		var userid = document.getElementById("userid").value;
		if(userid.length==0){
			document.getElementById("idalert").innerHTML="请输入您的账号";
		}else{
			document.getElementById("idalert").innerHTML="";
		}
	}
	function checkpwd(){
		var userpaw = document.getElementById("userpaw").value;
		var reg = /^\w{8,15}$/;
		if (!reg.test(userpaw)) {
			document.getElementById("pwdalert").innerHTML="请输入正确格式的密码";
		}else{
			document.getElementById("pwdalert").innerHTML="";
		}
	}

</script>
</html>