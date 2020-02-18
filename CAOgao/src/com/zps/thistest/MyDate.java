package com.zps.thistest;

public class MyDate {

private String year;

private String month;

private String day;


public MyDate() {
	this("1998","5","1");
	//MyDate("1998","5","1"); 不能这么调用
	
}


private void MyDate(String string, String string2, String string3) {
	// TODO Auto-generated method stub
	
}


public MyDate(String year,String month,String day) {
	  this.year =year;
	  this.month=month;
	  this.day=day;
	
	
}





public String getYear() {
	return year;
}

public void setYear(String year) {
	this.year = year;
}

public String getMonth() {
	return month;
}

public void setMonth(String month) {
	this.month = month;
}

public String getDay() {
	return day;
}

public void setDay(String day) {
	this.day = day;
}


	

}
