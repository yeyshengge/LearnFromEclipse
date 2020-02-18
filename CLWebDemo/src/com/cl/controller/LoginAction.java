package com.cl.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cl.biz.UsersBizI;
import com.cl.biz.impl.UsersBizImpl;
import com.cl.entity.Users;

public class LoginAction extends ActionSupport{
	
	String uname;
	String upwd;
	
	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getUpwd() {
		return upwd;
	}

	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}

	public void login(HttpServletRequest req, HttpServletResponse resp) {
		UsersBizI userbiz = new UsersBizImpl();
		try {
			PrintWriter pw = resp.getWriter();
			if(userbiz.login(uname, upwd)){
				pw.print("ok");
			}else{
				pw.print("no");
			}
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public void register(HttpServletRequest req, HttpServletResponse resp) {
		UsersBizI userbiz = new UsersBizImpl();
		Users user = new Users();
		user.setUname(uname);
		user.setUpwd(upwd);
		
		try {
			PrintWriter pw = resp.getWriter();
			if(userbiz.register(user)){
				pw.print("ok");
			}else{
				pw.print("no");
			}
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void changePwd(HttpServletRequest req, HttpServletResponse resp) {
		UsersBizI userbiz = new UsersBizImpl();
		try {
			PrintWriter pw = resp.getWriter();
			
			if(userbiz.changePwd(uname, upwd)){
				pw.print("ok");
			}else{
				pw.print("no");
			}
			pw.flush();
			pw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
}
