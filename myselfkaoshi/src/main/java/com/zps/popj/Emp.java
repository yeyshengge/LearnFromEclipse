package com.zps.popj;

import java.sql.Date;

public class Emp implements java.io.Serializable {
	private Integer eid;
	private String ename;
	private Integer deptid;
	private String deptname;
	private Integer age;
	private Integer gender;
	private Date workdate;
	
	public Date getWorkdate() {
		return workdate;
	}
	public void setWorkdate(Date workdate) {
		this.workdate = workdate;
	}
	public Emp() {
		// TODO Auto-generated constructor stub
	}
	public Integer getEid() {
		return eid;
	}
	public void setEid(Integer eid) {
		this.eid = eid;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public Integer getDeptid() {
		return deptid;
	}
	public void setDeptid(Integer deptid) {
		this.deptid = deptid;
	}
	public String getDeptname() {
		return deptname;
	}
	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public Integer getGender() {
		return gender;
	}
	public void setGender(Integer gender) {
		this.gender = gender;
	}
	
}
