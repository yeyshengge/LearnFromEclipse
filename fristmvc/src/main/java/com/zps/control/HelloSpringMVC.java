package com.zps.control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class HelloSpringMVC implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
	    ModelAndView mv =new ModelAndView();
		mv.addObject("hello","hello frist spring mvc");
		mv.setViewName("/WEB-INF/jsp/frist.jsp");
		return mv;
	}

}
