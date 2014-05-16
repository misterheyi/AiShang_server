package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.UploadAuth;

public class UploadAuthDao extends DBMain<UploadAuth> {

	@Override
	public void add(UploadAuth obj) throws ClassNotFoundException, SQLException {
		sql = "insert into uploadauth(users_id, allow_video_num, allow_picture_num,used_video_num,used_picture_num,is_open) values(?,?,?,?,?,?)";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getUsers_id());
		pst.setInt(2, obj.getAllow_video_num());
		pst.setInt(3, obj.getAllow_picture_num());
		pst.setInt(4, obj.getUsed_video_num());
		pst.setInt(5, obj.getUsed_picture_num());
		pst.setString(6, obj.getIs_open());
		pst.execute();
		release();
	}

	@Override
	public UploadAuth assemble(ResultSet rst) throws SQLException {
		UploadAuth auth = new UploadAuth();
		auth.setAllow_picture_num(rst.getInt("allow_picture_num"));
		auth.setAllow_video_num(rst.getInt("allow_video_num"));
		auth.setAuth_id(rst.getInt("auth_id"));
		auth.setIs_open(rst.getString("is_open"));
		auth.setUsed_picture_num(rst.getInt("used_picture_num"));
		auth.setUsed_video_num(rst.getInt("used_video_num"));
		auth.setUsers_id(rst.getInt("users_id"));
		return auth;
	}

	@Override
	public void delete(UploadAuth obj) throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ArrayList<UploadAuth> getAll() throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UploadAuth getById(int id) throws ClassNotFoundException,
			SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void modify(UploadAuth obj) throws ClassNotFoundException,
			SQLException {
		sql = "update uploadauth set allow_video_num = ?, allow_picture_num = ? ,used_video_num = ? , used_picture_num = ? , is_open = ? where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getAllow_video_num());
		pst.setInt(2, obj.getAllow_picture_num());
		pst.setInt(3, obj.getUsed_video_num());
		pst.setInt(4, obj.getUsed_picture_num());
		pst.setString(5, obj.getIs_open());
		pst.setInt(6, obj.getUsers_id());
		pst.execute();
		release();
	}
	
	public UploadAuth getUploadAuthByUid(int uid) throws ClassNotFoundException, SQLException{
		UploadAuth auth = new UploadAuth();
		sql = "select * from uploadauth where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		if (rst.next()) {
			auth = assemble(rst);
		}
		release();
		return auth;
	}

}
