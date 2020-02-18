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
			//��ȡ�ĵ�
			Document doc = reader.read(input);
			//��ø�Ŀ¼
			Element root = doc.getRootElement();
			//��ȡ��package�ڵ�
			Element packageEle = root.element("package");
			//��ȡ�����е�action�ڵ㼯��
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
		//��ȡ��action��ǩ�е�result��ǩ����
		List<Element> results = actionEle.elements("result");
		for (int j = 0; j < results.size(); j++) {
			addResultMap(results.get(j),resultMap);
		}
		oneAction.setResultMap(resultMap);
		//���������ļ��ж�ȡ��������Ϣ���浽actionMap�У���dopost��������
		actionMap.put(oneAction.getActionName(), oneAction);
	}
	
	public void addResultMap(Element resultEle,Map<String,Result> resultMap){
		Result result = new Result();
		result.setName(resultEle.attributeValue("name"));
		result.setIsRedirect(resultEle.attributeValue("redirect"));
		//��ȡresult��ǩ�е��ı�
		result.setUrl(resultEle.getText());
		resultMap.put(result.getName(), result);
	}
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//��ȡ�����·��
		String requestURI = req.getRequestURI();
		System.out.println("�����·���ǣ�"+requestURI);
		//������action��β����do��β(��������ֻ������.do��β������)����ȡ�����������
		String actionName = requestURI.substring(requestURI.lastIndexOf("/")+1,requestURI.lastIndexOf("."));
		//ͨ����������ƣ���ȡ����Ӧaction����
		ActionMapping map = actionMap.get(actionName);
		//����action�е���Ϣ����ȡ����Ӧ����ľ���·��
		String className = map.getActionClass();
		try {
			//ͨ���������������action�л�ȡ������
			Class cls = Class.forName(className);
			Object obj = cls.newInstance();
			//��ȡ�����������еı�Ԫ������
			Enumeration<String> params = req.getParameterNames();
			//�������ò����ķ��������ñ��Ĳ���
			setParameterValues(cls, obj, params, req);
			//ͨ��������ƻ�ȡ��ҵ���߼��Ĵ���������
			Method method = cls.getDeclaredMethod(actionMap.get(actionName).getActionMethod(),new Class[]{HttpServletRequest.class,HttpServletResponse.class});
			//���÷�������ȡ�����ص�·��
			String url = (String)method.invoke(obj,req,resp);
			Map<String,Result> resultMap = map.getResultMap();
			//��map���ҵ���Ӧ��url��תurl
			Result re = resultMap.get(url);
			String jspName = re.getUrl();
			String isRedirect = re.getIsRedirect();
			//��ת
			if(isRedirect.equals("true")){
				//�ض���
				resp.sendRedirect(jspName);
			}else{
				//ת��
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
	 * ͨ�����䣬���ö�Ӧ�ı�����ֵ
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
			//ͨ����Ӧ�ı�������ȡ�ַ�������ʽ���ҵ���Ӧ���������÷���
			methodName = "set"+theParams.substring(0,1).toUpperCase() + theParams.substring(1);
			//ͨ���ҵ��Ķ�Ӧ���������÷����������������õ������������
			try {
				method = theCla.getDeclaredMethod(methodName, new Class[]{String.class});
				//ͨ������Ļ��ƣ����ö�Ӧ�ķ����������Ĳ������õ���Ӧ�Ķ���������
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
