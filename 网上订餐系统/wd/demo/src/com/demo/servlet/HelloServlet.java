package com.demo.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	System.out.println("hello servlet");
	
	request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("name");
	System.out.println(name);
	
	
	response.setContentType("text/html;charset=utf-8");
	PrintWriter out = response.getWriter();
	out.print("<h1>Hello Servlet!</h1>");
	out.print("<h2>name="+name+"</h2>");
	
	response.flushBuffer();
}
}
