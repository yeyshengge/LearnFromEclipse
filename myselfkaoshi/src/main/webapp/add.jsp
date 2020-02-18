<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<form action="/add.do" method="post">
		<table border="1" cellpadding="0" cellspacing="0" width="800px"
		align="center">
			<thead>
			<tbody>
				<tr>
					<td>姓名</td>
					<!-- required 是html5当中加入进来对于表单验证这一块的支持 -->
					
					<td><input type="text" name="ename" value="" required ></td>
				</tr>
				<tr>
					<td>部门</td>
					<td>
					
						<select>
							<c:forEach items="${data }" var="d">
								<option  name="deptid" value="${d.did }">${d.dname }</option>
							</c:forEach>
							
							
						</select>
					
					</td>
				</tr>
				<tr>
					<td>年龄</td>
					<td><input type="number" name="age" value="" required></td>
				</tr>
				<tr>
					<td>性别</td>
					<td><input type="text" name="gender" value="" required></td>
				</tr>
				<tr>
					<td>入职时间</td>
					<td><input type="text" name="workdate" value="" required></td>
				</tr>
			</tbody>
		</table>
		<button >提交</button>
	</form>
</body>
</html>