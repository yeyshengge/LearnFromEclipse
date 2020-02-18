package com.zps.popj;

public class Dept implements java.io.Serializable {

	private Integer did;
	private String dname;
	
	public Dept() {
		
	}

	public Integer getDid() {
		return did;
	}

	public void setDid(Integer did) {
		this.did = did;
	}

	public String getDname() {
		return dname;
	}

	public void setDname(String dname) {
		this.dname = dname;
	}
	
	
}
