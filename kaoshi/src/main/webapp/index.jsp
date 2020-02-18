<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<script type="text/javascript">
	window.onload = function() {
		var tb = document.getElementById("tb");
		var tbody = tb.getElementsByTagName("tbody")[0];
		var trs = tbody.getElementsByTagName("tr");

		for (var i = 0; i < trs.length; i++) {
			if (i % 2 == 0) {
				trs[i].style.backgroundColor = "#888";
			}
		}
	};
</script>

</head>


<body>
	
	<form action="deletes.do" method="post">
	<table id="tb" border="1" cellpadding="0" cellspacing="0" width="800px"
		align="center">
		<thead>
			
			<tr align="center">
				<th>删除/批量</th>
				<th>会员编号</th>
				<th>会员姓名</th>
				<th>会员性别</th>
				<th>联系电话</th>
				<th>email地址</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${data }" var="e">
			<tr>
				<td>
					<input name="ids" type="checkbox" value="${e.userid }">
				</td>
				<td>${e.userid }</td>
			
				<td>${e.username  }</td>
				<td>
					<c:if test="${e.usersex == 1 }">男</c:if>
					<c:if test="${e.usersex == 2 }">女</c:if>
				</td>
				<td>${e.userphone }</td>
				<td>${e.email }</td>
				<!--  <td>
					<a href="delete.do?id=${e.userid }">删除</a> 
				
					
				</td>-->
			</tr>
			
			
			</c:forEach>
			
			
		</tbody>
	</table>
	<div style="width:100%;display:flex;justify-conent:center;"><button type="submit" style="width:100px;">批量删除</button></div>
	</form>
</body>
</html>