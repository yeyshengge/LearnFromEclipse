package com.cl.biz;

import com.cl.entity.Users;

public interface UsersBizI {
	
	/**
	 * 用户登录的方法
	 * @param uname 登录的用户名
	 * @param upwd  登录的密码
	 * @return 受影响的行数
	 */
	public boolean login(String uname,String upwd);

	public boolean register(Users user);
	
	public boolean changePwd(String uname,String upwd);
}
