package cn.edu.buaa.nlsde.bean;
//Á¬½ÓBean
import java.io.Serializable;
import java.sql.*;
public class ConnectionBean implements java.io.Serializable {
	private Connection vConnection = null;
	private boolean bUseState = false;
	public ConnectionBean() {
	}
	public ConnectionBean(Connection connection) {
		if (connection != null) {
			vConnection = connection;
		}
	}
	public Connection getConnection() {
		return vConnection;
	}
	public void setConnection(Connection connection) {
		vConnection = connection;
	}
	public void setUseState(boolean bUseState) {
		this.bUseState = bUseState;
	}
	public boolean getUseState() {
		return bUseState;
	}
	public void close() {
		try {
			vConnection.close();
		}
		catch (SQLException sqlException) {
			System.err.println(sqlException.getMessage());
		}
	}
}