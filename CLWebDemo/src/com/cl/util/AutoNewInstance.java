package com.cl.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import com.cl.annotation.Auto;

/**
 * ���������
 * �Զ�װ��ӿڶ����ʵ��
 * �Ժ���Transactionע��Ľ��з������������
 * 
 * ע�⣺
 * ��Ϊ��Ҫ��̬������ӿ����Դ�������
 * ��ˣ����뽫�������ഴ��Ϊ��Ա������
 * ��Ϊ����̬����ʹ�������ڲ���ķ�������ʵ�֣�
 * ���ֻΪһ����������ô�ɽ�������������Ծֲ�����������̬�����ڲ�����
 * @author Administrator
 *
 * @param <T> AutoNewInstance<T>������
 */
public class AutoNewInstance<T> {
	//�����������
	private T newInstance; 
	
	/**
	 * ͨ�����캯�����Զ�Ϊ�ӿڴ���ʵ����
	 * �Ըýӿڽ��ж�̬����ʵ������Ĺ���
	 * 
	 * �ѵ㣺����õ����������ӱ����������������õ�������ʱһ�µ�
	 * �����ͨ�����ݿ����ӳ��õ���Ӧ������
	 */
	public AutoNewInstance() {
		newInstance();
	}
	
	
	/**
	 * ��̬�������Զ�װ��ľ���ʵ��
	 */
	public void newInstance(){
		//ͨ��������ƣ���ȡ����ǰ�Ķ���������ֶε����飬����
		for (Field field : this.getClass().getDeclaredFields()) {
			//�ж��ֶ��Ƿ�����Զ�װ��ע��
			if (field.isAnnotationPresent(Auto.class)) {
				//��ȡ��ע���ֵ
				String implPath = field.getAnnotation(Auto.class).value();
				//�ж�ע���е�ֵ�Ƿ�Ϊ�գ�Ϊ���׳��쳣
				if("".equals(implPath.trim())){
					try {
						throw new BaseException("ע������Ҫ����ʵ���Ķ���·����");
					} catch (BaseException e) {
						e.printStackTrace();
					}
				}
				try {
					//ͨ���������������Ķ���·��������ʵ������
					Class<?> clz = Class.forName(implPath);
					newInstance = (T) clz.newInstance();
					T t = newInstance;
					//���ע���е�ֵ����dao���ع�dao��
					if(implPath.contains("dao")){
					//����һ����̬����������ڲ���
					t = (T)Proxy.newProxyInstance(field.getType()
							.getClassLoader(), clz.getInterfaces(), 
							new InvocationHandler() {
						//��дinvoke��������
						public Object invoke(Object proxy, 
								Method method,Object[] args) 
										throws Throwable {
							Object ob = null;
							//�ж��Ƿ���������ע��
							if(method.isAnnotationPresent(Transaction.class)){
								//�����������ע�⣬������
								TransactionManager.openTransaction();
								try {
									//�������÷���
									ob = method.invoke(newInstance, args);
									//�ύ����
									TransactionManager.commit();
								} catch (Exception e) {
									//�����ع�����
									TransactionManager.rollback();
									e.printStackTrace();
								}finally{
									//�ر�����
									TransactionManager.closeTransaction();
								}
							}else{
								//����������ֱ�ӵ��÷���
								ob = method.invoke(newInstance, args);
							}
							return ob;
						}
					});
				}
				//��Java�ķ����У�����ֶ�Ϊ˽�еģ�����������ֶν�������
				field.setAccessible(true);
				field.set(this, t);
			} catch (Exception e) {
				e.printStackTrace();
			}
			}
		}
	}
}
