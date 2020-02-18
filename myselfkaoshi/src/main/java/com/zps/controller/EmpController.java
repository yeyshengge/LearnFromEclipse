package com.zps.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import com.zps.popj.Dept;
import com.zps.popj.Emp;
import com.zps.services.EmpService;

@Controller
public class EmpController {

	@Autowired
	EmpService services;
	
	@RequestMapping("/load.do")
	public String querydata(HttpServletRequest request) {
		List<Emp> data = services.query();
		request.setAttribute("data", data);
		return "index";
	}
	
	
	@RequestMapping("/delete.do")
	public String delete(Integer id) {
		services.delete(id);
		
		return "redirect:load.do";
	}
	
	
	@RequestMapping("/deletes.do")
	public String deletes(Integer[] ids) {
		for (int i = 0; i < ids.length; i++) {
			services.delete(ids[i]);
		}
		
		return "redirect:load.do";
	}
	
	@RequestMapping("/get.do")
	public String get(Integer id,HttpServletRequest request) {
		Emp data = services.query(id);
		request.setAttribute("data", data);
		return "edit";
	}
	
	
	@RequestMapping("/update.do")
	public String update(Emp emp) {
		services.edit(emp);
		return "redirect:load.do";
	}
	
	
	@RequestMapping("/add.do")
	public String add(Emp emp) {
		services.add(emp);
		return "redirect:load.do";
	}

	
}

