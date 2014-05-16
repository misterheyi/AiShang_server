package com.aishang.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * 是所有DAO类的父类
 * 
 * @author Administrator
 * 
 */
public abstract class DBMain<E> {
	protected Connection con;
	protected PreparedStatement pst;
	protected ResultSet rst;
	protected String sql;

	/**
	 * 将指定SQL语句封装为一个PreparedStatement对象
	 * 
	 * @param sql
	 *            需封装的SQL语句
	 * @return 一个PreparedStatement对象
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	protected PreparedStatement getPrepareStatement(String sql) throws ClassNotFoundException, SQLException {
//		getRemotePST();
		 getLocalPST();
		return pst;
	}

	/**
	 * 本地数据库
	 * 
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	protected void getLocalPST() throws SQLException, ClassNotFoundException {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://127.0.0.1:3306/aishang";
		// -------------加载JDBC驱动------------------
		Class.forName(driver);
		// --------------获得数据库连接------------------
//		con = DriverManager.getConnection(url, "root", "2238447");
		con = DriverManager.getConnection(url, "root", "123456");
		// ------------封装SQL语句为可执行的对象-----------
		pst = con.prepareStatement(sql);
	}

	/**
	 * 百度数据库
	 * 
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	protected void getRemotePST() throws SQLException, ClassNotFoundException {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://sqld.duapp.com:4050/MynNbWZtAOPuKwXFfbBc";
		Class.forName(driver);
		con = DriverManager.getConnection(url, "3rYVogqZ1L85TDkkvPY267LG", "1ZmSK58dXrmX6gGD94b6MykWshOQvKwG");
		pst = con.prepareStatement(sql);
	}

	/**
	 * 释放数据库连接
	 * 
	 * @throws SQLException
	 */
	public void release() throws SQLException {
		// --------------释放数据库连接-----------------
		if (rst != null) {
			rst.close();
		}
		if (pst != null) {
			pst.close();
		}
		if (con != null) {
			con.close();
		}
	}

	public abstract ArrayList<E> getAll() throws ClassNotFoundException, SQLException;

	public abstract E getById(int id) throws ClassNotFoundException, SQLException;

	public abstract void add(E obj) throws ClassNotFoundException, SQLException;

	public abstract void modify(E obj) throws ClassNotFoundException, SQLException;

	public abstract void delete(E obj) throws ClassNotFoundException, SQLException;

	public abstract E assemble(ResultSet rst) throws SQLException;
}
