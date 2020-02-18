package com.zking.controller;

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

	public String execute() {
		if(uname.equals("admin") && upwd.equals("123123")){
			return SUCCESS;
		}else{
			return INPUT;
		}
	}
}
