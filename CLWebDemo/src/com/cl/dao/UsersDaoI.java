package com.cl.dao;

import java.util.List;

import com.cl.entity.Users;

public interface UsersDaoI {
	
	/**
	 * �û���¼�ķ���
	 * @param uname ��¼���û���
	 * @param upwd  ��¼������
	 * @return ��Ӱ�������
	 */
	public List<Object> login(String uname,String upwd);
	
	public int register(Users user);

	public int changePwd(String uname,String upwd);
}
