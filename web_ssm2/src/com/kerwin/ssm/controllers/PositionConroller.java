package com.kerwin.ssm.controllers;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kerwin.ssm.pojo.Position;
import com.kerwin.ssm.services.TestServices;

@Controller
public class PositionConroller {

	@Resource
	TestServices services;
	
	@RequestMapping("test.do")
	public String loadData(HttpServletRequest requset,Position position) {
		try {
			requset.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		System.out.println("--------"+position);
		List<Position> data = services.loadData(position);
		requset.setAttribute("data", data);
		
		
		return "list";
	}
	
	
}
