package com.zps.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.zps.popj.Emp;

public interface EmpDao {

	@Select("select e.userid,e.username,e.usersex,e.userphone,e.email \n" + 
			"from userinfo e\n" )
	public List<Emp> query();
	
	@Select("select * from userinfo where userid = #{userid}")
	public Emp queryById(int userid);
	
	@Insert("insert into userinfo(userid,username,usersex,userphone,email)\n" + 
			"values(#{userid},#{username},#{usersex},#{userphone},#{email})")
	public int add(Emp emp);

	@Update("update userinfo set userid = #{userid},username= #{username},usersex = #{usersex},userphone = #{userphone},email=#{email}\n" + 
			"where userid = #{userid}")
	public int edit(Emp emp);
	
	@Delete("delete from userinfo where userid = #{userid}")
	public int delete(int userid);
}
