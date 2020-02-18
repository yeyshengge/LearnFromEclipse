<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#main{
		width:300px;
		margin:0px auto;
	}
</style>
</head>
<body>
	<div id="main">
		<form action="Login.do" method="post">
			<table width="300px" >
				<tr>
					<td align="right">用户名:</td>
					<td align="left"><input type="text" name="uname"></td>
				</tr>
				<tr>
					<td align="right">密&nbsp;&nbsp;码:</td>
					<td align="left"><input type="password" name="upwd"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="登录">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>