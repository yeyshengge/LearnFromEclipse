package com.cl.biz.impl;

import java.util.List;


import com.cl.biz.UsersBizI;
import com.cl.dao.UsersDaoI;
import com.cl.dao.impl.UsersDaoImpl;
import com.cl.entity.Users;

public class UsersBizImpl implements UsersBizI{

	public boolean login(String uname, String upwd) {
		UsersDaoI udao = new UsersDaoImpl();
		List<Object> list = udao.login(uname, upwd);
		if(list.size() > 0){
			return true;
		}
		return false;
	}

	public boolean register(Users user) {
		UsersDaoI udao = new UsersDaoImpl();
		int result = udao.register(user);
		if(result > 0){
			return true;
		}
		return false;
	}
	
	public boolean changePwd(String uname, String upwd) {
		UsersDaoI udao = new UsersDaoImpl();
		int result = udao.changePwd(uname, upwd);
		if(result > 0){
			return true;
		}
		return false;
	}
	
}
