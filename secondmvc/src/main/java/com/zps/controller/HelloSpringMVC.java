package com.zps.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class HelloSpringMVC implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    ModelAndView mv=new ModelAndView();
		mv.addObject("hello", "hello second spring mvc");
		mv.setViewName("second");
	    return mv;
	}

}
