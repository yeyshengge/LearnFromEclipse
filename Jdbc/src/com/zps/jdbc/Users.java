package com.zps.jdbc;
@Table(tablename="users")
public class Users {
	
	public Users(int uid,String uname,int uage,String usex) {
		this.uid = uid;
		this.uname = uname;
		this.uage = uage;
		this.usex = usex;
	}
	
	public Users(){
		
	}
	
	@Primary
	@Autoincrement
	@Column(value="uid")
	private int uid;
	
	@Column(value="uname")
	private String uname;
	
	@Column(value="uage")
	private int uage;
	
	@Column(value="usex")
	private String usex;
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
	public int getUage() {
		return uage;
	}
	public void setUage(int uage) {
		this.uage = uage;
	}
	public String getUsex() {
		return usex;
	}
	public void setUsex(String usex) {
		this.usex = usex;
	}
}
