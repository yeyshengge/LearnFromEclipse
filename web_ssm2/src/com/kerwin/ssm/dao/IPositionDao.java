package com.kerwin.ssm.dao;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kerwin.ssm.pojo.Position;

public interface IPositionDao {

	
//	@Select("select \n" + 
//			"	id,province_id as provinceid,province_name as provincename,\n" + 
//			"	city_id as cityid,city_name as cityname,\n" + 
//			"	county_id as countyid,county_name as countyname,\n" + 
//			"	town_id as townid ,town_name as townname,\n" + 
//			"	village_id as villageid ,village_name as villagename\n" + 
//			" \n" + 
//			"from j_position")
//	public List<Position> loadData(RowBounds rb);
	
	public List<Position> loadData2(Position position,RowBounds rb);
	
}
