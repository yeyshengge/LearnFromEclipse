<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function checkform(){
		var username = document.getElementById("username");
		
		if(username.value == null || username.value ==""){
			alert("对不起，用户名不能为空");
			return false;
		}
	}
</script>

</head>
<body>

	<form action="update.do" method="post">
		<table border="1" cellpadding="0" cellspacing="0" width="800px"
		align="center">
			<thead>
			<tbody>
				<tr>
					<td>姓名</td>
					<!-- required 是html5当中加入进来对于表单验证这一块的支持 -->
					
					<td>
						<input id="username" type="text" name="username" value="${data.username }" required >
						<input id="userid" type="hidden" name="userid" value="${data.userid }"  >
					</td>
				</tr>
		
				<tr>
					<td>编号</td>
					<td><input type="number" name="age" value="${data.userid }" required></td>
				</tr>
				<tr>
					<td>性别</td>
					<td>
						<c:if test="${data.usersex == 1 }">
						男<input type="radio" name="usersex" checked="checked" value="1">
						女<input type="radio" name="usersex" value="2">
						</c:if>
						<c:if test="${data.usersex == 2 }">
						男<input type="radio" name="usersex"  value="1">
						女<input type="radio" name="usersex" checked="checked" value="2">
						</c:if>
					</td>
				</tr>
				<tr>
					<td>手机号码</td>
					<td><input type="number" name="userphone" value="${data.userphone }" required></td>
				</tr>
				<tr>
					<td>邮箱</td>
					<td><input type="text" name="userphone" value="${data.userphone }" required></td>
				</tr>
			</tbody>
		</table>
		<center>
			
			<button type="submit">提交</button>
		</center>
	</form>
</body>
</html>