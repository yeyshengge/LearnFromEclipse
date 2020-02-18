package com.kerwin.ssm.services;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.kerwin.ssm.dao.IPositionDao;
import com.kerwin.ssm.pojo.Position;

@Service
public class TestServices {

	
	//现在是tomcat 通过得到你给他的spring信息，他调用spring给你创建
	@Resource
	IPositionDao dao;
	
	public List<Position> loadData(Position position) {
		List<Position> data = dao.loadData2(position,new RowBounds(0,10));
		return data;
	}
	
}
