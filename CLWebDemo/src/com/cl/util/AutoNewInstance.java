package com.cl.util;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

import com.cl.annotation.Auto;

/**
 * 管理代理类
 * 自动装配接口对象的实例
 * 对含有Transaction注解的进行方法的事务管理
 * 
 * 注意：
 * 因为需要动态给多个接口属性创建代理，
 * 因此，必须将代理子类创建为成员变量，
 * 因为，动态代理使用匿名内部类的方法来做实现，
 * 如果只为一个创建，那么可将被代理的子类以局部变量最终形态传入内部即可
 * @author Administrator
 *
 * @param <T> AutoNewInstance<T>代表泛型
 */
public class AutoNewInstance<T> {
	//被代理的子类
	private T newInstance; 
	
	/**
	 * 通过构造函数，自动为接口创建实例，
	 * 对该接口进行动态代理，实现事务的管理
	 * 
	 * 难点：事务得到的数据连接必须与正常操作所得到的连接时一致的
	 * 解决：通过数据库连接池拿到相应的连接
	 */
	public AutoNewInstance() {
		newInstance();
	}
	
	
	/**
	 * 动态代理与自动装配的具体实现
	 */
	public void newInstance(){
		//通过反射机制，获取到当前的对象的所有字段的数组，迭代
		for (Field field : this.getClass().getDeclaredFields()) {
			//判断字段是否包含自动装配注解
			if (field.isAnnotationPresent(Auto.class)) {
				//获取到注解的值
				String implPath = field.getAnnotation(Auto.class).value();
				//判断注解中的值是否为空，为空抛出异常
				if("".equals(implPath.trim())){
					try {
						throw new BaseException("注解上需要配置实例的对象路径！");
					} catch (BaseException e) {
						e.printStackTrace();
					}
				}
				try {
					//通过类加载器，传入的对象路径，加载实例对象
					Class<?> clz = Class.forName(implPath);
					newInstance = (T) clz.newInstance();
					T t = newInstance;
					//如果注解中的值包含dao，回滚dao层
					if(implPath.contains("dao")){
					//生成一个动态代理的匿名内部类
					t = (T)Proxy.newProxyInstance(field.getType()
							.getClassLoader(), clz.getInterfaces(), 
							new InvocationHandler() {
						//重写invoke方法拦截
						public Object invoke(Object proxy, 
								Method method,Object[] args) 
										throws Throwable {
							Object ob = null;
							//判断是否包含事务的注解
							if(method.isAnnotationPresent(Transaction.class)){
								//如果包含事务注解，打开事务
								TransactionManager.openTransaction();
								try {
									//继续调用方法
									ob = method.invoke(newInstance, args);
									//提交事务
									TransactionManager.commit();
								} catch (Exception e) {
									//报错，回滚事务
									TransactionManager.rollback();
									e.printStackTrace();
								}finally{
									//关闭事务
									TransactionManager.closeTransaction();
								}
							}else{
								//不包含事务，直接调用方法
								ob = method.invoke(newInstance, args);
							}
							return ob;
						}
					});
				}
				//在Java的反射中，如果字段为私有的，则必须对这个字段进行设置
				field.setAccessible(true);
				field.set(this, t);
			} catch (Exception e) {
				e.printStackTrace();
			}
			}
		}
	}
}
