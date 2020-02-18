package com.cl.dao;

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

import com.cl.annotation.Autoincrement;
import com.cl.annotation.Column;
import com.cl.annotation.Primary;
import com.cl.annotation.Table;
import com.cl.util.BaseException;
import com.cl.util.ConnectionUtil;

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
		ConnectionUtil util = new ConnectionUtil();
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
		ConnectionUtil util = new ConnectionUtil();
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
        	ConnectionUtil util = new ConnectionUtil();
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
    	ConnectionUtil util = new ConnectionUtil();
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
				throw new BaseException();
			} catch (BaseException e) {
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
    	sql.append(");");
//    	System.out.println(sql.toString());
    	BaseDao db = new BaseDao();
    	//���������Ѿ�д�õ�executeUpdate������Ӷ���
    	System.out.println(sql.toString());
    	int result = db.executeUpdate(sql.toString(), null);
    	return result;
    }
}
