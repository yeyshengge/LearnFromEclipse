package com.cl.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

//��ʾ���ע���ʹ�õĵط�
@Target(ElementType.TYPE)
//��ʾ���ע��ĵڿ�ʼʱ��
@Retention(RetentionPolicy.RUNTIME)
public @interface Table {
	String tablename();
}
