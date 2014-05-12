package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aishang.db.DBMain;
import com.aishang.db.bean.AdVideo;

public class AdVideoDAO extends DBMain<AdVideo> {

	@Override
	public ArrayList<AdVideo> getAll() throws ClassNotFoundException, SQLException {
		ArrayList<AdVideo> list = new ArrayList<AdVideo>();
		sql = "select * from adVideo";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	public ArrayList<AdVideo> getAllById(int id) throws ClassNotFoundException, SQLException {
		ArrayList<AdVideo> list = new ArrayList<AdVideo>();
		sql = "select * from adVideo where adVideo_id > ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	//App
	/**
	 * 根据agentId,storeId获取上级美发店，代理商和超管的待机视频
	 */
	public ArrayList<AdVideo> getAllByUid(int agentId,int storeId) throws ClassNotFoundException, SQLException {
		ArrayList<AdVideo> list = new ArrayList<AdVideo>();
		//获取到一级管理员上传的视频
		String userId = agentId + "," + storeId;
		List<Integer> managerIds = new UsersDAO().getManagerUserId();//获取管理员Id
		for(Integer uid:managerIds){
			userId+=","+uid;
		}
		sql = "select * from adVideo where users_id in ("+userId+")";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}
	
	/**
	 * 获取单个用户上传的待机视频
	 */
	public ArrayList<AdVideo> getVideoByUid(int id) throws ClassNotFoundException, SQLException {
		ArrayList<AdVideo> list = new ArrayList<AdVideo>();
		sql = "select * from adVideo where users_id =?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	@Override
	public AdVideo getById(int id) throws ClassNotFoundException, SQLException {
		sql = "select * from adVideo where adVideo_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		if (rst.next()) {
			AdVideo users = assemble(rst);
			release();
			return users;
		}
		release();
		return null;
	}

	@Override
	public void add(AdVideo obj) throws ClassNotFoundException, SQLException {
		sql = "insert into adVideo(adVideo_desc, adVideo_path, adVideo_count, users_id, adVideo_type) values(?,?,?,?,?)";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getAdVideo_desc());
		pst.setString(2, obj.getAdVideo_path());
		pst.setInt(3, obj.getAdVideo_count());
		pst.setInt(4, obj.getUsers_id());
		pst.setInt(5, obj.getAdVideo_type());
		pst.execute();
		release();
	}

	@Override
	public void modify(AdVideo obj) throws ClassNotFoundException, SQLException {

	}

	//App
	public void modifyCount(int count, int id) throws ClassNotFoundException, SQLException {
		sql = "update adVideo set adVideo_count = ? where adVideo_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, count);
		pst.setInt(2, id);
		pst.execute();
		release();
	}

	@Override
	public void delete(AdVideo obj) throws ClassNotFoundException, SQLException {

	}

	public void deleteById(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from adVideo where adVideo_id=?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	public void deleteByUID(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from adVideo where users_id=?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	@Override
	public AdVideo assemble(ResultSet rst) throws SQLException {
		AdVideo a = new AdVideo();
		a.setAdVideo_count(rst.getInt("adVideo_count"));
		a.setAdVideo_id(rst.getInt("adVideo_id"));
		a.setAdVideo_desc(rst.getString("adVideo_desc"));
		a.setAdVideo_path(rst.getString("adVideo_path"));
		a.setAdVideo_type(rst.getInt("adVideo_type"));
		a.setUsers_id(rst.getInt("users_id"));
		return a;
	}
	
	/**
	 * 根据参数包含多个用户以,号分开，获得视频列表
	 */
	public ArrayList<AdVideo> getAllByUids(String uids) throws ClassNotFoundException, SQLException {
		ArrayList<AdVideo> list = new ArrayList<AdVideo>();
		sql = "select * from adVideo where users_id in ("+uids+")";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

}
