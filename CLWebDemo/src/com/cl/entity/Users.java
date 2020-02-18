package com.cl.entity;

import com.cl.annotation.Autoincrement;
import com.cl.annotation.Column;
import com.cl.annotation.Primary;
import com.cl.annotation.Table;

@Table(tablename="users")
public class Users {
	
	@Primary
	@Autoincrement
	@Column(value="uid")
	private int uid;
	
	@Column(value="uname")
	private String uname;
	
	@Column(value="upwd")
	private String upwd;
	
	public Users(int uid, String uname, String upwd) {
		this.uid = uid;
		this.uname = uname;
		this.upwd = upwd;
	}
	public Users() {
	}
	
	
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
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
}
