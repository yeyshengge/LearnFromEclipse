package com.cl.biz;

import com.cl.entity.Users;

public interface UsersBizI {
	
	/**
	 * �û���¼�ķ���
	 * @param uname ��¼���û���
	 * @param upwd  ��¼������
	 * @return ��Ӱ�������
	 */
	public boolean login(String uname,String upwd);

	public boolean register(Users user);
	
	public boolean changePwd(String uname,String upwd);
}
