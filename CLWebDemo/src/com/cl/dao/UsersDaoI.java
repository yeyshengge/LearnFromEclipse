package com.cl.dao;

import java.util.List;

import com.cl.entity.Users;

public interface UsersDaoI {
	
	/**
	 * 用户登录的方法
	 * @param uname 登录的用户名
	 * @param upwd  登录的密码
	 * @return 受影响的行数
	 */
	public List<Object> login(String uname,String upwd);
	
	public int register(Users user);

	public int changePwd(String uname,String upwd);
}
