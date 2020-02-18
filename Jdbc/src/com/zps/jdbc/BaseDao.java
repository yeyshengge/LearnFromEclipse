package com.zps.jdbc;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class BaseDao {
	
	
	private Connection conn = null;
    private PreparedStatement pstmt = null;
    public ResultSet rs = null;
    
	
	
	/**
	 * 通用的增删改的方法
	 * @param param 传入相对应的参数
	 * @return 受影响的行数
	 */
	public int executeUpdate(String sql, Object... prams) {
		ConnectionUtil util = ConnectionUtil.instansof();
		conn = util.getConnection();
        try {
            this.pstmt = conn.prepareStatement(sql);
            if (prams != null) {
                for (int i = 0; i < prams.length; i++) {
                    this.pstmt.setObject(i + 1, prams[i]);
                }
            }

            return this.pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	util.closeAll();
        }
        return 0;
    }
	
	/**
     * 新增，返回主键

     * @param sql
     * @param prams
     * @return
     */
	public int executeInsert(String sql, Object... prams) {
		ConnectionUtil util = ConnectionUtil.instansof();
		conn = util.getConnection();
        try {
            
            //传入参数：STATEMENT.RETURN_GENERATED_KEYS，指定返回生成的主键  
            this.pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            
            if (prams != null) {
                for (int i = 0; i < prams.length; i++) {
                    this.pstmt.setObject(i + 1, prams[i]);
                }
            }
            //执行sql
            int count = this.pstmt.executeUpdate();
            //返回的主键
            int autoIncKey = 0;
            if(count > 0){
                ResultSet rs = pstmt.getGeneratedKeys(); //获取结果
                
                if (rs.next()) {
                    autoIncKey = rs.getInt(1);//取得ID
                } else {
                    // throw an exception from here
                    
                    System.out.println("插入语句出错，没有获取到新增的ID！");
                }
            }
            return autoIncKey;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            util.closeAll();
        }
        return 0;
    }
	
    
	
	/**
     * 查询通用
     * @Description 无
     * @Version V 1.0
     * @param sql
     * @param prams
     */
    public void executeQuery(String sql, Object... prams) {
        try {
        	ConnectionUtil util = ConnectionUtil.instansof();
    		conn = util.getConnection();
            this.pstmt = conn.prepareStatement(sql);
            if (prams != null) {
                for (int i = 0; i < prams.length; i++) {
                    this.pstmt.setObject(i + 1, prams[i]);
                }
            }
            this.rs = this.pstmt.executeQuery();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    /** 
     * 获取结果集，并将结果放在List中 
     *  
     * @param sql 
     * SQL语句 
     * @return List 
     *  结果集 
     */  
    public List<Object> excuteQueryList(String sql, Object... params) {  
        // 执行SQL获得结果集  
        ResultSet rs = executeQueryRS(sql, params);   
        // 创建ResultSetMetaData对象  
        ResultSetMetaData rsmd = null;     
        // 结果集列数  
        int columnCount = 0;  
        try {  
            rsmd = rs.getMetaData();   
            // 获得结果集列数  
            columnCount = rsmd.getColumnCount();  
        } catch (SQLException e1) {  
            System.out.println(e1.getMessage());  
        }  
        // 创建List  
        List<Object> list = new ArrayList<Object>();  
        try {  
            // 将ResultSet的结果保存到List中  
            while (rs.next()) {  
                Map<String, Object> map = new HashMap<String, Object>();  
                for (int i = 1; i <= columnCount; i++) {  
                    map.put(rsmd.getColumnLabel(i), rs.getObject(i));  
                }  
                list.add(map);  
            }  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        } finally {  
            // 关闭所有资源  
//            util.closeAll();  
        }  
  
        return list;  
    }  
    
    
    
    /** 
     * SQL 查询将查询结果直接放入ResultSet中 
     * @param sql SQL语句 
     * @param params 参数数组，若没有参数则为null 
     * @return 结果集 
     */  
    private ResultSet executeQueryRS(String sql, Object[] params) {  
    	// 获得连接  
    	ConnectionUtil util = ConnectionUtil.instansof();
		conn = util.getConnection();
        try {  
            // 调用SQL  
        	 pstmt = conn.prepareStatement(sql);     
            // 参数赋值  
            if (params != null) {  
                for (int i = 0; i < params.length; i++) {  
                	pstmt.setObject(i + 1, params[i]);  
                }  
            }   
            // 执行  
            rs = pstmt.executeQuery();  
  
        } catch (SQLException e) {  
            System.out.println(e.getMessage());  
        }  
        return rs;  
    }
    
//    public int add(Object obj){
//    	Class cc = obj.getClass();
//    	String tableName = cc.getSimpleName();
//    	StringBuffer sb = new StringBuffer();
//    	sb.append("insert into ");
//    	sb.append(tableName + "(");
//    	Field[] fs = cc.getDeclaredFields();
//    	for (int i = 0; i < fs.length; i++) {
////			System.out.println(fs[i].getName());
//    		String name = fs[i].getName();
//    		sb.append(fs[i].getName() + ",");
//    		
//    		
//		}
//    	
//    	for (int i = 0; i < fs.length; i++) {
//    		String name = fs[i].getName();
//    		String methodName = "get"+name.substring(0,1).toUpperCase()+name.substring(1);
//			try {
//				Method method = cc.getDeclaredMethod(methodName, null);
//				Object value = method.invoke(obj, null);
//				System.out.println(value);
//			} catch (Exception e) {
//				e.printStackTrace();
//			} 
//		}
//    	
//    	sb.delete(sb.length()-1, sb.length());
//    	sb.append(") values(");
//    	System.out.println(sb.toString());
//    	
//    	return -1;
//    }
    
    /**
     * 传入一个对象，将对象添加到对应的表中
     * @param obj 任意一个对象
     * @return
     */
    public int add(Object obj){
    	//创建一个StringBuffer对象，用来存放拼接sql语句
    	StringBuffer sql = new StringBuffer();
    	sql.append("insert into ");
    	Class cc = obj.getClass();
    	//得到表名
    	//String tableName = cc.getSimpleName();
    	//通过注解获取到对象所对应的数据库的表名
    	Table table = (Table)cc.getAnnotation(Table.class);
    	if(table != null){
    		sql.append(table.tablename() + "(");
    	}else{
    		try {
				throw new MyException();
			} catch (MyException e) {
				e.printStackTrace();
			}
    	}
    	//通过反射的机制，得到对象中的所有的字段名，存入到一个数组
    	Field[] fs =  cc.getDeclaredFields();
    	for (int i = 0; i < fs.length; i++) {
    		
    		Primary primary = fs[i].getAnnotation(Primary.class);
    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
    		if(primary == null && autoincrement == null){
    			Column column = fs[i].getAnnotation(Column.class);
    			sql.append(column.value() + ",");
    		}
		}
    	sql.delete(sql.length()-1, sql.length());
    	sql.append(") values(");
    	for (int i = 0; i < fs.length; i++) {
			String name = fs[i].getName();
			//通过得到的字段名，还有字符串截取，拼接的方式，拼接出方法名
			String methodName = "get" + name.substring(0,1).toUpperCase()+name.substring(1);
			try {
				//通过反射的机制，调用方法，传入方法名和参数
				Method method = cc.getDeclaredMethod(methodName, null);
				//通过反射的机制调用方法，返回对应的值
				Object value = method.invoke(obj, null);
				Primary primary = fs[i].getAnnotation(Primary.class);
	    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
	    		if(primary == null && autoincrement == null){
	    			//判断这个值是什么类型的
					//判断是否是int或者是integer类型的
					if(Integer.TYPE == value.getClass() || Integer.class == value.getClass()){
						sql.append(value + ",");
					}else if(String.class == value.getClass()){
						sql.append("'"+value + "',");
					}
	    		}
			}  catch (Exception e) {
				e.printStackTrace();
			}
		}
    	sql.delete(sql.length()-1, sql.length());
    	sql.append(")");
//    	System.out.println(sql.toString());
    	BaseDao db = new BaseDao();
    	//调用上面已经写好的executeUpdate方法添加对象
    	System.out.println(sql.toString());
    	int result = db.executeUpdate(sql.toString(), null);
    	return result;
    }
    /**
     * 
     * @param obj
     * @return
     */
    
    
    //删除
    public int delete(Object obj) {
    	//创建一个StringBuffer对象来存放拼接的SQL语句
    	StringBuffer sql=new StringBuffer();
    	sql.append("delete from"+" ");
    	Class cc=obj.getClass();
    	//得到表名
    	//通过注解获取到对象所对应的数据库表名
    	Table table =(Table)cc.getAnnotation(Table.class);
    	if(table!=null)
    	{
    		sql.append(" "+table.tablename()+" where"+" ");
    	}else {
    		        try {
    		        	throw new MyException();
    		        }catch(MyException e) {
    		        	e.printStackTrace();}
    		        }
    	
    	//通过反射的机制，得到对象中所有的字段名，存放到一个数组
    	Field[]  fs=cc.getDeclaredFields();
    	for (int i = 0; i < fs.length; i++) {
    		Primary primary = fs[i].getAnnotation(Primary.class);
    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
    		if(primary == null && autoincrement == null){
    			Column column = fs[i].getAnnotation(Column.class);
    			sql.append(column.value() + "='");
    			
    			String name = fs[i].getName();
    			//通过得到的字段名，还有字符串截取，拼接的方式，拼接出方法名
    			String methodName = "get" + name.substring(0,1).toUpperCase()+name.substring(1);
    			try {
    				//通过反射的机制，调用方法，传入方法名和参数
    				Method method = cc.getDeclaredMethod(methodName, null);
    				//通过反射的机制调用方法，返回对应的值
    				Object value = method.invoke(obj, null);
    				Primary primary1 = fs[i].getAnnotation(Primary.class);
    	    		Autoincrement autoincrement1= fs[i].getAnnotation(Autoincrement.class);
    	    		if(primary1 == null && autoincrement1== null){
    	    			//判断这个值是什么类型的
    					//判断是否是int或者是integer类型的
    					if(Integer.TYPE == value.getClass() || Integer.class == value.getClass()){
    						sql.append(value + "' and ");
    					}else if(String.class == value.getClass()){
    						sql.append(value + "' and "+" ");
    					  System.out.println(sql.toString());	
    	    		}
    	    		}   	    		
    			}  catch (Exception e) {
    				e.printStackTrace();
    			}		
    		}
		}
    	
    	sql.delete(sql.length()-5, sql.length());
    	System.out.println(sql.toString());
			
    	BaseDao db = new BaseDao();
    	//调用上面已经写好的executeUpdate方法添加对象
    	
    	int result = db.executeUpdate(sql.toString(), null);
    	return result;
    	
    }

    
    
  //修改  
    public int update(Object obj) {
    	//创建一个StringBuffer对象来存放拼接的SQL语句
    	StringBuffer sql=new StringBuffer();
    	sql.append("update"+"");
    	Class cc=obj.getClass();
    	//得到表名
    	//通过注解获取到对象所对应的数据库表名
    	Table table =(Table)cc.getAnnotation(Table.class);
    	if(table!=null)
    	{
    		sql.append(" "+table.tablename()+" set"+" ");
    	}else {
    		        try {
    		        	throw new MyException();
    		        }catch(MyException e) {
    		        	e.printStackTrace();}
    		        }
    	
    	//通过反射的机制，得到对象中所有的字段名，存放到一个数组
    	Field[]  fs=cc.getDeclaredFields();
    	for (int i = 0; i < fs.length; i++) {
    		Primary primary = fs[i].getAnnotation(Primary.class);
    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
    		if(primary == null && autoincrement == null){
    			Column column = fs[i].getAnnotation(Column.class);
    			
    			sql.append(column.value() + "='");
    			
    			
    			String name = fs[i].getName();
    			
    			//通过得到的字段名，还有字符串截取，拼接的方式，拼接出方法名
    			String methodName = "get" + name.substring(0,1).toUpperCase()+name.substring(1);
    			
    			try {
    				//通过反射的机制，调用方法，传入方法名和参数
    				Method method = cc.getDeclaredMethod(methodName, null);
    				//通过反射的机制调用方法，返回对应的值
    				Object value = method.invoke(obj, null);
    				Primary primary1 = fs[i].getAnnotation(Primary.class);
    	    		Autoincrement autoincrement1= fs[i].getAnnotation(Autoincrement.class);
    	    		if(primary1 == null && autoincrement1== null){
    	    			//判断这个值是什么类型的
    					//判断是否是int或者是integer类型的
    					if(Integer.TYPE == value.getClass() || Integer.class == value.getClass()){
    						sql.append(value + "' , ");
    					}else if(String.class == value.getClass()){
    						sql.append(value + "',"+" ");
    					 System.out.println(sql.toString());	
    	    		}
    	    		}   	    		
    			}  catch (Exception e) {
    				e.printStackTrace();
    			}		
    		}
		}//System.out.println(fs[0].getName());
    	
    	sql.delete(sql.length()-2, sql.length());
    	System.out.println(sql.toString());
			
    	BaseDao db = new BaseDao();
    	//调用上面已经写好的executeUpdate方法添加对象
    	System.out.println(sql.toString()+"where"+" "+"uid = '"+fs[0].getName()+"'");
    	int uid=6;
    	int result = db.executeUpdate(sql.toString()+"where"+" "+"uid = '"+uid+"'", null);
    	return result;
    	
    }
    
    
    
    
    public static void main(String[] args) {
    
    	BaseDao db = new BaseDao();
    	
		//Users u = new Users(2,"张四",18,"男");
		//int result = db.add(u);
		//System.out.println(result);
		
		//Users d = new Users(2,"张ds",18,"男");
		//int result1 =db.delete(d);
		//System.out.println(result1);
    		
    	Users x =new Users(5,"daddaad",88,"女");
    	int result2 = db.update(x);
    	System.out.println(result2);
    	
    	
//    	Properties p = new Properties();
//    	InputStream is = Thread.class.getClassLoader().getResourceAsStream("db.properties");
//    	InputStream is = BaseDao.class.getClassLoader().getResourceAsStream("db.properties");
//    	System.out.println(is);
    	
    	
    	
    	
    	
    	
//    	String sql = "insert into users(uid,uname,uage,usex) values(?,?,?,?)";
//    	BaseDao db = new BaseDao();
//    	int result = db.executeUpdate(sql, 1,"张三",18,"男");
//    	System.out.println(result);
    	
    	
    	
//		
    	
	}
    
}
