package com.cl.util;

import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Stack;

/**
 * ���ݿ����ӳأ�����ʵ��
 * ������
 * 	���ݿ����ӳأ�
 * 	�洢������ݿ����Ӷ���ļ���
 * 	���ݿ����Ӷ���ConnectionUtil
 * 	1.��Ҫ�����������ݿ����Ӷ���connection
 *     2.���������Ƿ�Ϊ����״̬
 *     
 * 	�����ӳ��еĳ�Ա������
 * 	1���������ӳ�ʼ��������
 * 	2���������������������
 * 	3�����ݿ������Զ����ݵ�����
 * 	4���洢���ݿ����ӵļ���stack��vector;
 * 
 *  ���ӳصĴ������û�ʹ�����ݿ����ӣ�
 * 	1���洢�������ӵļ������󣬿�ʹ�ö�ջ�������л����������洢����֤�̰߳�ȫ
 * 	2�����û���Ҫ�������ݿ��ʱ����Ҫ���̳߳��л�ȡһ�����ݿ����ӵ�Ȩ����
 * 		������Ҫ�жϵ�ǰ�����ݿ����Ƿ��п��е����ݿ����ӣ�
 * 		���������ô�ͽ����е����ݿ����ӿ���������������ݿ����ӵ��û�ʹ��
 * 		����Ѿ�û���㹻�����������ṩ�����û���Ҳ�͵�ǰ���������Ѿ������������ӳص����������������
 * 		��ô���ø��û��ȸ�һС�ᣬ�ڿ����ӳ����Ƿ��п�������ӣ��������û�У�
 * 		��ô�͸������ӳؿ�������Զ���������������һ�����������ݿ����ӣ��������û����������ķ������ݿ� 
 * 		���û��õ����ݿ����ӵ�ʹ��Ȩ֮����Ҫ�������ݿ������״̬��Ϊ�����У��������û��õ���ͬ������ 
 *  3�����û�ʹ������������֮�����ʱ����Ҫ�������ݿ�����ӣ�Ҳ���ǽ���ǰ�����ݿ������ٴηŻ����ӳ�
 * 		������Ҫ�����ݿ����Ӷ����״̬����Ϊ����
 * 	
 *     ��ȡ����ʹ�ö�̬������ʵ��
 */
public class DBPool {
	/**
	 * �洢���ݿ����ӵļ��ϣ����������ӳ�
	 */
	private  Stack<ConnectionUtil> dbPoolStack=null;
	
	/**
	 * 	ͳ�Ƶ�ǰ���������������������������ӵĴ���
	 */
	private int current;
	
	/**
	 * ʵ�������ӳض���
	 * ͨ����̬�ڲ�����ʵ�������ش���ʵ��
	 */
	private static class DBPoolnstance{
		private static final DBPool dbPool = new DBPool();
	}
	
	/**
	 * �����ݿ����ӳض���Ĺ��캯��˽�л�����ֹ�����������ʵ����
	 * ��ʼ��һ�����������ݿ����ӣ���������һ���������������ӵ��������ӳ�
	 * �����ݿ����ӳ�����󱻵��õ�ʱ��ͼ��س���һ�����������ݿ�����
	 */
	private DBPool(){
		if(dbPoolStack==null){
			dbPoolStack = new Stack<ConnectionUtil>();
		}
		for(int i=0;i<DB.DB_INIT_CONNECTIONS;i++){
			dbPoolStack.push(createDBConn());
		}
	}
	
	/**
	 * �������ӳض����ʵ��
	 * @return
	 */
	public static DBPool getInstance(){
		return DBPoolnstance.dbPool;
	}
	
	/**
	 * ����һ�����ݿ����ӵĶ���
	 * @return
	 */
	public ConnectionUtil createDBConn(){
		ConnectionUtil dbconn = new ConnectionUtil();
		if(dbPoolStack.size()<11){
			try {
				//��ȡ���ݿ�Ԫ���ݣ����ڲ鿴���ݿ��������������ݿ�������
				DatabaseMetaData dbMetaData = dbconn.getConnection().getMetaData();
				//�õ���ǰ���ʵ����ݿ������������������
				int maxDBConnect = dbMetaData.getMaxConnections();
				//�ж����ݿ�����������Ƿ������ã�
				//������ã��жϵ�ǰ���õ���������Ƿ񳬹����ݿ�������ķ�Χ��
				//�����������ô���������ݿ���������Ϊ���ݿ�����������������
				if(maxDBConnect>0&&maxDBConnect>DB.DB_MAX_CONNECTIONS){
					DB.setDB_MAX_CONNECTIONS(maxDBConnect);
				}
				dbconn = DBInvocationHandler.getInstance().bind(dbconn);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dbconn;
	}
	
	/**
	 * ���һ�����ݿ����Ӷ���
	 * �жϻ�ȡ�����Ƿ�Ϊ���У����Ϊ���У���ô�򽫸����ӷ��أ����ҽ�����״̬����Ϊ���ǿ���
	 * @return
	 */
	public ConnectionUtil getConnection(){
		ConnectionUtil dbconn = null;
		if(dbPoolStack.empty()){
			//������һ�ٺ���,����ѭ������
			int conut = 0;
			conut = wait(100,conut);
			//������������ȡ���Ӷ�û�п�������ӣ���ô�´���һ������
			if(conut>=2){
				//�����ǰ����������С�����������-�Զ���������
				//�����䴴���µ����ӣ�
				//�������û�в�����ǰ������ӣ������䴴��һ������
				if(current<DB.DB_MAX_CONNECTIONS-DB.DB_INCREMENT_CONNECTIONS){
					incrementConection();
				}else{
					dbPoolStack.add(createDBConn());
				}
			}else{
				getConnection();
			}
		}
		for(Iterator<ConnectionUtil> it = dbPoolStack.iterator();it.hasNext(); ){
			ConnectionUtil conn = (ConnectionUtil)it.next();
			//�ж����ݿ������Ƿ���У�����ǿ��е���ô�ͽ������ӷ��ظ��û�ʹ��
			if(conn.getIsFree()){
 				dbconn = dbPoolStack.pop();
				//����ȡ�������ݿ�����״̬����Ϊ�ǿ���
 				dbconn.setIsFree(false);
				break;
			}else{
				//����˵�������ӳ����쳣������ɾ����������Ϊ�µ����ӣ��������ӳ���������
				dbPoolStack.pop();
				dbPoolStack.push(new ConnectionUtil());
			}
		}
		current++;
		return dbconn;
	}
	
	/**
	 * �ͷ����ݿ�����
	 * ����ǰʹ�ý���������״̬����Ϊ���У����ҽ�������ӽ����ӳص�ջ��
	 */
	public void releaseConnection(ConnectionUtil dbconn){
		try {
			dbconn.getConnection().close();
			dbPoolStack.push(dbconn);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * ��û�п������ӵ�ʱ������µ�����
	 */
	public void incrementConection(){
		for(int i=0;i<DB.DB_INCREMENT_CONNECTIONS;i++){
			dbPoolStack.add(createDBConn());
		}
	}
	
	/**
	 * ����ڻ�ȡ���ӳ��е�����ʱ���������ӳ�Ϊ�գ���ô��ȴ�һ��ʱ�䣬ʱ������ٻ�ȡ���ӣ�
	 * ����û�з������ӵ��û���������򽫸����ӽ�����ǰ�����ȡ���ӵ��û���
	 * ���û�У���ô����һ�����������ӣ��Ա�֤�û����ʵ�����
	 * @param mSeconds
	 */
	private int wait(int ms,int conut) {
		try {
			// �����ñ��߳�����һ��ʱ�䣬���ߵ�ʱ���ɲ���mSecondsȷ��
			Thread.sleep(ms);
			conut++;
		} catch (InterruptedException e) {
			// �����쳣������쳣��Ϣ
			e.printStackTrace();
		}
		return conut;
	}
	
	/**
	 * ��ȡ���ݿ����ӳص�ջ����
	 * @return
	 */
	public Stack<ConnectionUtil> getDbPoolStack() {
		return dbPoolStack;
	}
}
