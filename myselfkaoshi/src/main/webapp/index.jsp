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
	<a href="loaddept.do">增加员工</a>
	<form action="deletes.do" method="post">
	<table id="tb" border="1" cellpadding="0" cellspacing="0" width="800px"
		align="center">
		<thead>
			<tr>
				<th colspan="6"><a href="loaddept.do">添加</a></th>

			</tr>
			<tr align="center">
				<th>选择</th>
				<th>员工姓名</th>
				<th>部门</th>
				<th>年龄</th>
				<th>性别</th>
				<th>入职时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${data }" var="e">
			<tr>
				<td>
					<input name="ids" type="checkbox" value="${e.eid }">
				</td>
				<td>${e.ename }</td>
				<td>${e.deptname }</td>
				<td>${e.age }</td>
				<td>
					<c:if test="${e.gender == 1 }">男</c:if>
					<c:if test="${e.gender == 2 }">女</c:if>
				</td>
				<td>${e.workdate }</td>
				<td>
					<a href="delete.do?id=${e.eid }">删除</a> 
				
					<a href="get.do?id=${e.eid }">修改</a>
				</td>
			</tr>
			
			
			</c:forEach>
			
			
		</tbody>
	</table>
	<button type="submit">删除</button>
	</form>
</body>
</html>