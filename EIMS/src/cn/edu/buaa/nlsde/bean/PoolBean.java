package cn.edu.buaa.nlsde.bean;
//连接池
import java.io.Serializable;
import java.sql.*;
import java.util.*;
public class PoolBean implements java.io.Serializable {
	private String strDriver = "net.sourceforge.jtds.jdbc.Driver";
	private String strURL = "jdbc:jtds:sqlserver://localhost:1433/EIMS";
	private int iSize = 1;
	private String strUserName = "sa";
	private String strPassword = "password";
	private ConnectionBean vConnectionBean = null;
	private Vector vPool = null;
	public PoolBean() {
	}
	public void setDriver(String strDriver) {
		if (strDriver != null) {
			this.strDriver = strDriver;
		}
	}
	public String getDriver() {
		return strDriver;
	}
	public void setURL(String strURL) {
		if (strURL != null) {
			this.strURL = strURL;
		}
	}
	public String getURL() {
		return strURL;
	}
	public void setSize(int iSize) {
		if (iSize > 1) {
			this.iSize = iSize;
		}
	}
	public int getSize() {
		return iSize;
	}
	public String getUserName() {
		return strUserName;
	}
	public void setUserName(String strUserName) {
		if (strUserName != null) {
			this.strUserName = strUserName;
		}
	}
	public void setPassword(String strPassword) {
		if (strPassword != null) {
			this.strPassword = strPassword;
		}
	}
	public String getPassword() {
		return strPassword;
	}
	public void setConnectionBean(ConnectionBean vConnectionBean) {
		if (vConnectionBean != null) {
			this.vConnectionBean = vConnectionBean;
		}
	}
	public ConnectionBean getConnectionBean() throws Exception {
		Connection vConnection = getConnection();
		ConnectionBean vConnectionBean =
			new ConnectionBean(vConnection);
		vConnectionBean.setUseState(true);
		return vConnectionBean;
	}
	private Connection createConnection() throws Exception {
		Connection vConnection = null;
		vConnection =
			DriverManager.getConnection(
				strURL,
				strUserName,
				strPassword);
		return vConnection;
	}
	public synchronized void initializePool() throws Exception {
		if (strDriver == null) {
			throw new Exception("没有提供驱动程序名称!");
		}
		if (strURL == null) {
			throw new Exception("没有提供URL!");
		}
		if (iSize < 1) {
			throw new Exception("连接池大小小于1!");
		}
		try {
			Class.forName(strDriver);
			for (int iIndex = 0; iIndex < iSize; iIndex++) {
				Connection vConnection = createConnection();
				if (vConnection != null) {
					ConnectionBean vConnectionBean =
						new ConnectionBean(vConnection);
					addConnection(vConnectionBean);
				}
			}
		}
		catch (Exception eException) {
			System.err.println(eException.getMessage());
			throw new Exception(eException.getMessage());
		}
	}
	private void addConnection(ConnectionBean vConnectionBean) {
		if (vPool == null) {
			vPool = new Vector(iSize);
		}
		vPool.addElement(vConnectionBean);
	}
	public synchronized void releaseConnection(Connection vConnection) {
		for (int iIndex = 0; iIndex < vPool.size(); iIndex++) {
			ConnectionBean vConnectionBean =
				(ConnectionBean)vPool.elementAt(iIndex);
			if (vConnectionBean.getConnection() == vConnection) {
				System.err.println("释放第" + iIndex + "个连接!");
				vConnectionBean.setUseState(false);
				break;
			}
		}
	}
	public synchronized Connection getConnection() throws Exception {
		ConnectionBean vConnectionBean = null;
		for (int iIndex = 0; iIndex < vPool.size(); iIndex++) {
			vConnectionBean = (ConnectionBean)vPool.elementAt(iIndex);
			if (vConnectionBean.getUseState() == false) {
				vConnectionBean.setUseState(true);
				Connection vConnection =
					vConnectionBean.getConnection();
				return vConnection;
			}
		}
		try {
			Connection vConnection = createConnection();
			vConnectionBean = new ConnectionBean(vConnection);
			vConnectionBean.setUseState(true);
			vPool.addElement(vConnectionBean);
		}
		catch (Exception eException) {
			System.err.println(eException.getMessage());
			throw new Exception(eException.getMessage());
		}
		return vConnectionBean.getConnection();
	}
	public synchronized void emptyPool() {
		for (int iIndex = 0; iIndex < vPool.size(); iIndex++) {
			System.err.println("关闭第" + iIndex + "JDBC连接!");
			ConnectionBean vConnectionBean =
				(ConnectionBean)vPool.elementAt(iIndex);
			if (vConnectionBean.getUseState() == false) {
				vConnectionBean.close();
			}
			else {
				try {
					java.lang.Thread.sleep(20000);
					vConnectionBean.close();
				}
				catch (InterruptedException interruptedException) {
					System.err.println(
						interruptedException.getMessage());
				}
			}
		}
	}
}