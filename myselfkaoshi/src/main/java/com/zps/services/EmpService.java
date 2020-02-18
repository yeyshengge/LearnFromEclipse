package com.zps.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zps.dao.EmpDao;
import com.zps.popj.Emp;

@Component
public class EmpService {

	@Autowired
	EmpDao dao;
	
	
	public List<Emp> query(){
		return dao.query();
	}
	
	public Emp query(Integer id){
		return dao.queryById(id);
	}
	
	
	public boolean add(Emp emp) {
//		int result = dao.add(emp);
//		if(result > 0) {
//			return true;
//		}
//		return false;
		return dao.add(emp) > 0;
	}
	
	
	public boolean edit(Emp emp) {
		return dao.edit(emp) > 0;
	}


	public boolean delete(Integer id) {
		return dao.delete(id) > 0;
	}
	
	
}
