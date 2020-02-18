package com.cl.dao.impl;

import java.util.List;



import com.cl.dao.BaseDao;
import com.cl.dao.UsersDaoI;
import com.cl.entity.Users;

public class UsersDaoImpl implements UsersDaoI{

	public List<Object> login(String uname,String upwd){
		BaseDao db = new BaseDao();
		String sql = "select * from users where uname=? and upwd=?";
		List<Object> list = db.excuteQueryList(sql, uname,upwd);
		return list;
	}
	
	public int register(Users user){
		BaseDao db = new BaseDao();
		int result = db.add(user);
		return result;
	}

	public int changePwd(String uname, String upwd) {
		BaseDao db = new BaseDao();
		String sql = "update users set upwd=? where uname=?";
		int result = db.executeUpdate(sql, upwd,uname);
		return result;
	}
}
