package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.UserGroup;

public class UserGroupDAO extends DBMain<UserGroup> {

	@Override
	public ArrayList<UserGroup> getAll() throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserGroup getById(int id) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void add(UserGroup obj) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void modify(UserGroup obj) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(UserGroup obj) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public UserGroup assemble(ResultSet rst) throws SQLException {
		UserGroup u = new UserGroup();
		u.setUserGroup_desc(rst.getString("userGroup_desc"));
		u.setUserGroup_id(rst.getInt("userGroup_id"));
		u.setUserGroup_name(rst.getString("userGroup_name"));
		return u;
	}

}
