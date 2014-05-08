package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.Version;

public class VersionDAO extends DBMain<Version> {

	@Override
	public ArrayList<Version> getAll() throws ClassNotFoundException, SQLException {
		ArrayList<Version> list = new ArrayList<Version>();
		sql = "select * from appVersion order by version desc";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	@Override
	public Version getById(int id) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	public Version checkUpdate(String version) throws ClassNotFoundException, SQLException {
		sql = "select * from appVersion where version > ? limit 0,1";
		pst = getPrepareStatement(sql);
		pst.setString(1, version);
		rst = pst.executeQuery();
		if (rst.next()) {
			Version v = assemble(rst);
			release();
			return v;
		}
		release();
		return null;
	}

	@Override
	public void add(Version obj) throws ClassNotFoundException, SQLException {
		sql = "insert into appVersion(path, version) values(?,?)";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getPath());
		pst.setString(2, obj.getVersion());
		pst.execute();
		release();
	}

	@Override
	public void modify(Version obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public void delete(Version obj) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public Version assemble(ResultSet rst) throws SQLException {
		Version v = new Version();
		v.setAd_id(rst.getInt("av_id"));
		v.setPath(rst.getString("path"));
		v.setVersion(rst.getString("version"));
		return v;
	}

}
