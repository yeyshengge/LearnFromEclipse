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
	 * ͨ�õ���ɾ�ĵķ���
	 * @param param �������Ӧ�Ĳ���
	 * @return ��Ӱ�������
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
     * ��������������

     * @param sql
     * @param prams
     * @return
     */
	public int executeInsert(String sql, Object... prams) {
		ConnectionUtil util = ConnectionUtil.instansof();
		conn = util.getConnection();
        try {
            
            //���������STATEMENT.RETURN_GENERATED_KEYS��ָ���������ɵ�����  
            this.pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
            
            if (prams != null) {
                for (int i = 0; i < prams.length; i++) {
                    this.pstmt.setObject(i + 1, prams[i]);
                }
            }
            //ִ��sql
            int count = this.pstmt.executeUpdate();
            //���ص�����
            int autoIncKey = 0;
            if(count > 0){
                ResultSet rs = pstmt.getGeneratedKeys(); //��ȡ���
                
                if (rs.next()) {
                    autoIncKey = rs.getInt(1);//ȡ��ID
                } else {
                    // throw an exception from here
                    
                    System.out.println("����������û�л�ȡ��������ID��");
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
     * ��ѯͨ��
     * @Description ��
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
     * ��ȡ������������������List�� 
     *  
     * @param sql 
     * SQL��� 
     * @return List 
     *  ����� 
     */  
    public List<Object> excuteQueryList(String sql, Object... params) {  
        // ִ��SQL��ý����  
        ResultSet rs = executeQueryRS(sql, params);   
        // ����ResultSetMetaData����  
        ResultSetMetaData rsmd = null;     
        // ���������  
        int columnCount = 0;  
        try {  
            rsmd = rs.getMetaData();   
            // ��ý��������  
            columnCount = rsmd.getColumnCount();  
        } catch (SQLException e1) {  
            System.out.println(e1.getMessage());  
        }  
        // ����List  
        List<Object> list = new ArrayList<Object>();  
        try {  
            // ��ResultSet�Ľ�����浽List��  
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
            // �ر�������Դ  
//            util.closeAll();  
        }  
  
        return list;  
    }  
    
    
    
    /** 
     * SQL ��ѯ����ѯ���ֱ�ӷ���ResultSet�� 
     * @param sql SQL��� 
     * @param params �������飬��û�в�����Ϊnull 
     * @return ����� 
     */  
    private ResultSet executeQueryRS(String sql, Object[] params) {  
    	// �������  
    	ConnectionUtil util = ConnectionUtil.instansof();
		conn = util.getConnection();
        try {  
            // ����SQL  
        	 pstmt = conn.prepareStatement(sql);     
            // ������ֵ  
            if (params != null) {  
                for (int i = 0; i < params.length; i++) {  
                	pstmt.setObject(i + 1, params[i]);  
                }  
            }   
            // ִ��  
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
     * ����һ�����󣬽�������ӵ���Ӧ�ı���
     * @param obj ����һ������
     * @return
     */
    public int add(Object obj){
    	//����һ��StringBuffer�����������ƴ��sql���
    	StringBuffer sql = new StringBuffer();
    	sql.append("insert into ");
    	Class cc = obj.getClass();
    	//�õ�����
    	//String tableName = cc.getSimpleName();
    	//ͨ��ע���ȡ����������Ӧ�����ݿ�ı���
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
    	//ͨ������Ļ��ƣ��õ������е����е��ֶ��������뵽һ������
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
			//ͨ���õ����ֶ����������ַ�����ȡ��ƴ�ӵķ�ʽ��ƴ�ӳ�������
			String methodName = "get" + name.substring(0,1).toUpperCase()+name.substring(1);
			try {
				//ͨ������Ļ��ƣ����÷��������뷽�����Ͳ���
				Method method = cc.getDeclaredMethod(methodName, null);
				//ͨ������Ļ��Ƶ��÷��������ض�Ӧ��ֵ
				Object value = method.invoke(obj, null);
				Primary primary = fs[i].getAnnotation(Primary.class);
	    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
	    		if(primary == null && autoincrement == null){
	    			//�ж����ֵ��ʲô���͵�
					//�ж��Ƿ���int������integer���͵�
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
    	//���������Ѿ�д�õ�executeUpdate������Ӷ���
    	System.out.println(sql.toString());
    	int result = db.executeUpdate(sql.toString(), null);
    	return result;
    }
    /**
     * 
     * @param obj
     * @return
     */
    
    
    //ɾ��
    public int delete(Object obj) {
    	//����һ��StringBuffer���������ƴ�ӵ�SQL���
    	StringBuffer sql=new StringBuffer();
    	sql.append("delete from"+" ");
    	Class cc=obj.getClass();
    	//�õ�����
    	//ͨ��ע���ȡ����������Ӧ�����ݿ����
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
    	
    	//ͨ������Ļ��ƣ��õ����������е��ֶ�������ŵ�һ������
    	Field[]  fs=cc.getDeclaredFields();
    	for (int i = 0; i < fs.length; i++) {
    		Primary primary = fs[i].getAnnotation(Primary.class);
    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
    		if(primary == null && autoincrement == null){
    			Column column = fs[i].getAnnotation(Column.class);
    			sql.append(column.value() + "='");
    			
    			String name = fs[i].getName();
    			//ͨ���õ����ֶ����������ַ�����ȡ��ƴ�ӵķ�ʽ��ƴ�ӳ�������
    			String methodName = "get" + name.substring(0,1).toUpperCase()+name.substring(1);
    			try {
    				//ͨ������Ļ��ƣ����÷��������뷽�����Ͳ���
    				Method method = cc.getDeclaredMethod(methodName, null);
    				//ͨ������Ļ��Ƶ��÷��������ض�Ӧ��ֵ
    				Object value = method.invoke(obj, null);
    				Primary primary1 = fs[i].getAnnotation(Primary.class);
    	    		Autoincrement autoincrement1= fs[i].getAnnotation(Autoincrement.class);
    	    		if(primary1 == null && autoincrement1== null){
    	    			//�ж����ֵ��ʲô���͵�
    					//�ж��Ƿ���int������integer���͵�
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
    	//���������Ѿ�д�õ�executeUpdate������Ӷ���
    	
    	int result = db.executeUpdate(sql.toString(), null);
    	return result;
    	
    }

    
    
  //�޸�  
    public int update(Object obj) {
    	//����һ��StringBuffer���������ƴ�ӵ�SQL���
    	StringBuffer sql=new StringBuffer();
    	sql.append("update"+"");
    	Class cc=obj.getClass();
    	//�õ�����
    	//ͨ��ע���ȡ����������Ӧ�����ݿ����
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
    	
    	//ͨ������Ļ��ƣ��õ����������е��ֶ�������ŵ�һ������
    	Field[]  fs=cc.getDeclaredFields();
    	for (int i = 0; i < fs.length; i++) {
    		Primary primary = fs[i].getAnnotation(Primary.class);
    		Autoincrement autoincrement = fs[i].getAnnotation(Autoincrement.class);
    		if(primary == null && autoincrement == null){
    			Column column = fs[i].getAnnotation(Column.class);
    			
    			sql.append(column.value() + "='");
    			
    			
    			String name = fs[i].getName();
    			
    			//ͨ���õ����ֶ����������ַ�����ȡ��ƴ�ӵķ�ʽ��ƴ�ӳ�������
    			String methodName = "get" + name.substring(0,1).toUpperCase()+name.substring(1);
    			
    			try {
    				//ͨ������Ļ��ƣ����÷��������뷽�����Ͳ���
    				Method method = cc.getDeclaredMethod(methodName, null);
    				//ͨ������Ļ��Ƶ��÷��������ض�Ӧ��ֵ
    				Object value = method.invoke(obj, null);
    				Primary primary1 = fs[i].getAnnotation(Primary.class);
    	    		Autoincrement autoincrement1= fs[i].getAnnotation(Autoincrement.class);
    	    		if(primary1 == null && autoincrement1== null){
    	    			//�ж����ֵ��ʲô���͵�
    					//�ж��Ƿ���int������integer���͵�
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
    	//���������Ѿ�д�õ�executeUpdate������Ӷ���
    	System.out.println(sql.toString()+"where"+" "+"uid = '"+fs[0].getName()+"'");
    	int uid=6;
    	int result = db.executeUpdate(sql.toString()+"where"+" "+"uid = '"+uid+"'", null);
    	return result;
    	
    }
    
    
    
    
    public static void main(String[] args) {
    
    	BaseDao db = new BaseDao();
    	
		//Users u = new Users(2,"����",18,"��");
		//int result = db.add(u);
		//System.out.println(result);
		
		//Users d = new Users(2,"��ds",18,"��");
		//int result1 =db.delete(d);
		//System.out.println(result1);
    		
    	Users x =new Users(5,"daddaad",88,"Ů");
    	int result2 = db.update(x);
    	System.out.println(result2);
    	
    	
//    	Properties p = new Properties();
//    	InputStream is = Thread.class.getClassLoader().getResourceAsStream("db.properties");
//    	InputStream is = BaseDao.class.getClassLoader().getResourceAsStream("db.properties");
//    	System.out.println(is);
    	
    	
    	
    	
    	
    	
//    	String sql = "insert into users(uid,uname,uage,usex) values(?,?,?,?)";
//    	BaseDao db = new BaseDao();
//    	int result = db.executeUpdate(sql, 1,"����",18,"��");
//    	System.out.println(result);
    	
    	
    	
//		
    	
	}
    
}
