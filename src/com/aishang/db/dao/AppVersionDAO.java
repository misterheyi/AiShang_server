package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.AppVersion;

public class AppVersionDAO extends DBMain<AppVersion> {

	@Override
	public ArrayList<AppVersion> getAll() throws ClassNotFoundException, SQLException {

		return null;
	}

	@Override
	public AppVersion getById(int id) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void add(AppVersion obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public void modify(AppVersion obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public void delete(AppVersion obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public AppVersion assemble(ResultSet rst) throws SQLException {
		AppVersion version = new AppVersion();
		version.setApp_id(rst.getInt("app_id"));
		version.setApp_path(rst.getString("app_path"));
		version.setVersion_name(rst.getString("version_name"));
		return version;
	}

}
