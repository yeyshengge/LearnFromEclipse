package com.cl.controller;


import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.cl.entity.ActionMapping;
import com.cl.entity.Result;

public class ActionServlet extends HttpServlet{
	
	private Map<String , ActionMapping> actionMap = new HashMap<String , ActionMapping>();
	private List<Element> actions = new ArrayList<Element>();
	
	
	public void init(ServletConfig config) throws ServletException {
		String configXml = config.getInitParameter("configName");
		SAXReader reader = new SAXReader();
		InputStream input = this.getClass().getClassLoader().getResourceAsStream(configXml);
		try {
			//读取文档
			Document doc = reader.read(input);
			//获得根目录
			Element root = doc.getRootElement();
			//获取到package节点
			Element packageEle = root.element("package");
			//获取到所有的action节点集合
			actions = packageEle.elements("action");
			for (int i = 0; i < actions.size(); i++) {
				addActions(actions.get(i));
			}
			
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	public void addActions(Element actionEle){
		Map<String,Result> resultMap = new HashMap<String,Result>();
		ActionMapping oneAction = new ActionMapping();
		
		oneAction.setActionName(actionEle.attributeValue("name"));
		oneAction.setActionClass(actionEle.attributeValue("class"));
		oneAction.setActionMethod(actionEle.attributeValue("method"));
		//获取到action标签中的result标签集合
		List<Element> results = actionEle.elements("result");
		for (int j = 0; j < results.size(); j++) {
			addResultMap(results.get(j),resultMap);
		}
		oneAction.setResultMap(resultMap);
		//将从配置文件中读取出来的信息保存到actionMap中，让dopost方法调用
		actionMap.put(oneAction.getActionName(), oneAction);
	}
	
	public void addResultMap(Element resultEle,Map<String,Result> resultMap){
		Result result = new Result();
		result.setName(resultEle.attributeValue("name"));
		result.setIsRedirect(resultEle.attributeValue("redirect"));
		//获取result标签中的文本
		result.setUrl(resultEle.getText());
		resultMap.put(result.getName(), result);
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//获取请求的路径
		String requestURI = req.getRequestURI();
		System.out.println("请求的路径是："+requestURI);
		//不管是action结尾还是do结尾(我们这里只做了以.do结尾的请求)，获取到请求的名称
		String actionName = requestURI.substring(requestURI.lastIndexOf("/")+1,requestURI.lastIndexOf("."));
		//通过请求的名称，获取到对应action配置
		ActionMapping map = actionMap.get(actionName);
		//根据action中的信息，获取到对应的类的具体路径
		String className = map.getActionClass();
		try {
			//通过类加载器，加载action中获取到的类
			Class cls = Class.forName(className);
			Object obj = cls.newInstance();
			//获取到请求中所有的表单元素名称
			Enumeration<String> params = req.getParameterNames();
			//调用设置参数的方法，设置表单的参数
			setParameterValues(cls, obj, params, req);
			//通过反射机制获取到业务逻辑的处理方法对象
			Method method = cls.getDeclaredMethod(actionMap.get(actionName).getActionMethod(),new Class[]{HttpServletRequest.class,HttpServletResponse.class});
			//调用方法，获取到返回的路径
			String url = (String)method.invoke(obj,req,resp);
			Map<String,Result> resultMap = map.getResultMap();
			//从map中找到对应的url跳转url
			Result re = resultMap.get(url);
			String jspName = re.getUrl();
			String isRedirect = re.getIsRedirect();
			//跳转
			if(isRedirect.equals("true")){
				//重定向
				resp.sendRedirect(jspName);
			}else{
				//转发
				req.getRequestDispatcher(jspName).forward(req, resp);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 通过反射，设置对应的表单参数值
	 * @param theCla
	 * @param theObj
	 * @param params
	 * @param request
	 */
	void setParameterValues(Class theCla,Object theObj,Enumeration<String> params,HttpServletRequest request){
		String theParams = "";
		Method method = null;
		String methodName = "";
		while(params.hasMoreElements()){
			theParams = params.nextElement();
			//通过对应的表单名，截取字符串的形式，找到对应的属性设置方法
			methodName = "set"+theParams.substring(0,1).toUpperCase() + theParams.substring(1);
			//通过找到的对应的属性设置方法，将表单参数设置到对象的属性中
			try {
				method = theCla.getDeclaredMethod(methodName, new Class[]{String.class});
				//通过反射的机制，调用对应的方法，将表单的参数设置到对应的对象属性中
				method.invoke(theObj, request.getParameter(theParams));
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (SecurityException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
			
		}
	}
}
