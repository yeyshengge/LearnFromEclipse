package com.cl.entity;

import java.util.HashMap;
import java.util.Map;

public class ActionMapping {
	private String actionName;
	private String actionClass;
	private String actionMethod;
	
	public String getActionMethod() {
		return actionMethod;
	}
	public void setActionMethod(String actionMethod) {
		this.actionMethod = actionMethod;
	}
	private Map<String, Result> resultMap = new HashMap<String, Result>();
	
	public Map<String, Result> getResultMap() {
		return resultMap;
	}
	public void setResultMap(Map<String, Result> resultMap) {
		this.resultMap = resultMap;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}
	public String getActionClass() {
		return actionClass;
	}
	public void setActionClass(String actionClass) {
		this.actionClass = actionClass;
	}
	
	
}
