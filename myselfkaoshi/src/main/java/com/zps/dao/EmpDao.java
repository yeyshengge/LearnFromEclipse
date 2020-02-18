package com.zps.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.zps.popj.Emp;

public interface EmpDao {

	@Select("select e.eid,e.ename,d.dname deptname,e.age,gender,e.workDate \n" + 
			"from tb_emp e\n" + 
			"inner join tb_dept d\n" + 
			"on e.`dept_id` = d.`did`")
	public List<Emp> query();
	
	@Select("select * from tb_emp where eid = #{id}")
	public Emp queryById(Integer id);
	
	@Insert("insert into tb_emp(ename,dept_id,age,gender,workdate)\n" + 
			"values(#{ename},#{deptid},#{age},#{gender},#{workdate})")
	public int add(Emp emp);

	@Update("update tb_emp set ename= #{ename},dept_id = #{deptid},age = #{age},gender = #{gender},workdate=#{workdate}\n" + 
			"where eid = #{eid}")
	public int edit(Emp emp);
	
	@Delete("delete from tb_emp where eid = #{id}")
	public int delete(Integer id);
}
