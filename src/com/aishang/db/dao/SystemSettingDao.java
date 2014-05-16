package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.SystemSetting;

public class SystemSettingDao extends DBMain<SystemSetting> {

	@Override
	public void add(SystemSetting obj) throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public SystemSetting assemble(ResultSet rst) throws SQLException {
		SystemSetting setting = new SystemSetting();
		setting.setSetting_id(rst.getInt("setting_id"));
		setting.setSetting_type(rst.getString("setting_type"));
		setting.setSetting_value(rst.getString("setting_value"));
		return setting;
	}

	@Override
	public void delete(SystemSetting obj) throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ArrayList<SystemSetting> getAll() throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SystemSetting getById(int id) throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void modify(SystemSetting obj) throws ClassNotFoundException,
			SQLException {
		sql = "update system_setting set setting_value = ? where setting_id = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getSetting_value());
		pst.setInt(2, obj.getSetting_id());
		pst.execute();
		release();
	}
	
	public SystemSetting getByType(String type) throws ClassNotFoundException, SQLException{
		SystemSetting systemSetting = new SystemSetting();
		sql = "select * from system_setting where setting_type = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, type);
		rst = pst.executeQuery();
		if (rst.next()) {
			systemSetting = assemble(rst);
		}
		release();
		return systemSetting;
	}

}
