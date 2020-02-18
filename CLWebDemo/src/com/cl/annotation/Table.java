package com.cl.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

//表示这个注解的使用的地方
@Target(ElementType.TYPE)
//表示这个注解的第开始时间
@Retention(RetentionPolicy.RUNTIME)
public @interface Table {
	String tablename();
}
