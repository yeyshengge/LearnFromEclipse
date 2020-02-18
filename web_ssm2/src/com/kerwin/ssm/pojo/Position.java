package com.kerwin.ssm.pojo;

import java.util.Arrays;
import java.util.List;

public class Position implements java.io.Serializable {

	
	
	private List<String> list;
	
	private String[] strs;
	
	
	
	public List<String> getList() {
		return list;
	}
	public void setList(List<String> list) {
		this.list = list;
	}
	public String[] getStrs() {
		return strs;
	}
	public void setStrs(String[] strs) {
		this.strs = strs;
	}
	private int id = 1;
	private String provinceid;
	private String provincename;
	private String cityid;
	private String cityname;
	private String countyid;
	private String countyname;
	private String townid;
	private String townname;
	private String villageid;
	private String villagename;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProvinceid() {
		return provinceid;
	}
	public void setProvinceid(String provinceid) {
		this.provinceid = provinceid;
	}
	public String getProvincename() {
		return provincename;
	}
	public void setProvincename(String provincename) {
		this.provincename = provincename;
	}
	public String getCityid() {
		return cityid;
	}
	public void setCityid(String cityid) {
		this.cityid = cityid;
	}
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	public String getCountyid() {
		return countyid;
	}
	public void setCountyid(String countyid) {
		this.countyid = countyid;
	}
	public String getCountyname() {
		return countyname;
	}
	public void setCountyname(String countyname) {
		this.countyname = countyname;
	}
	public String getTownid() {
		return townid;
	}
	public void setTownid(String townid) {
		this.townid = townid;
	}
	public String getTownname() {
		return townname;
	}
	public void setTownname(String townname) {
		this.townname = townname;
	}
	public String getVillageid() {
		return villageid;
	}
	public void setVillageid(String villageid) {
		this.villageid = villageid;
	}
	public String getVillagename() {
		return villagename;
	}
	public void setVillagename(String villagename) {
		this.villagename = villagename;
	}
	public Position() {
		// TODO Auto-generated constructor stub
	}
	
	public Position(int id, String provinceid, String provincename, String cityid, String cityname, String countyid,
			String countyname, String townid, String townname, String villageid, String villagename) {
		super();
		this.id = id;
		this.provinceid = provinceid;
		this.provincename = provincename;
		this.cityid = cityid;
		this.cityname = cityname;
		this.countyid = countyid;
		this.countyname = countyname;
		this.townid = townid;
		this.townname = townname;
		this.villageid = villageid;
		this.villagename = villagename;
	}
	@Override
	public String toString() {
		return "Position [list=" + list + ", strs=" + Arrays.toString(strs) + ", id=" + id + ", provinceid="
				+ provinceid + ", provincename=" + provincename + ", cityid=" + cityid + ", cityname=" + cityname
				+ ", countyid=" + countyid + ", countyname=" + countyname + ", townid=" + townid + ", townname="
				+ townname + ", villageid=" + villageid + ", villagename=" + villagename + "]";
	}
	
	
}
