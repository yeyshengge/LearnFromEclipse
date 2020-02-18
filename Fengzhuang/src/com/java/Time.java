package com.java;

public class Time {
private int hour;
private int minute;
private int second;


public int getHour() {
	return hour;
}
public void setHour(int hour) {
	if(hour>24||hour<0){System.out.println("ÊäÈë´íÎó");}
	else{System.out.println(hour);}
}
public int getMinute() {
	return minute;
}
public void setMinute(int minute) {
	this.minute = minute;
}
public int getSecond() {
	return second;
}
public void setSecond(int second) {
	this.second = second;
}

}


