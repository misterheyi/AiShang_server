package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aishang.db.DBMain;
import com.aishang.db.bean.AdPicture;

public class AdPictureDAO extends DBMain<AdPicture> {

	@Override
	public ArrayList<AdPicture> getAll() throws ClassNotFoundException, SQLException {
		return null;
	}

	@Override
	public AdPicture getById(int id) throws ClassNotFoundException, SQLException {
		sql = "select * from adPicture where adPicture_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		if (rst.next()) {
			AdPicture adpicture = assemble(rst);
			release();
			return adpicture;
		}
		release();
		return null;
	}

	//App
	public ArrayList<AdPicture> getAllByUid(int id) throws ClassNotFoundException, SQLException {
		ArrayList<AdPicture> list = new ArrayList<AdPicture>();
		sql = "select * from adPicture where users_id = ? order by adPictureGroup_id";
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
	public ArrayList<AdPicture> getScollPicture(String id) throws ClassNotFoundException, SQLException {
		ArrayList<AdPicture> list = new ArrayList<AdPicture>();
		sql = "select * from adPicture where adPictureGroup_id =4 and (users_id = ? or users_id in (" +
				"select users_id from users where userGroup_id =1 " +	//超管Id
				"union select users_id from userRelation where users_id2 = ?))";//代理商Id
		pst = getPrepareStatement(sql);
		pst.setString(1, id);
		pst.setString(2, id);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	@Override
	public void add(AdPicture obj) throws ClassNotFoundException, SQLException {
		sql = "insert into adPicture(adPicture_path, adPicture_desc, adPictureGroup_id, users_id) values(?,?,?,?)";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getAdPicture_path());
		pst.setString(2, obj.getAdPicture_desc());
		pst.setInt(3, obj.getAdPictureGroup_id());
		pst.setInt(4, obj.getUsers_id());
		pst.execute();
		release();
	}

	@Override
	public void modify(AdPicture obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public void delete(AdPicture obj) throws ClassNotFoundException, SQLException {

	}

	public void deleteById(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from adPicture where adPicture_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	public void deleteByUID(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from adPicture where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	@Override
	public AdPicture assemble(ResultSet rst) throws SQLException {
		AdPicture a = new AdPicture();
		a.setAdPicture_id(rst.getInt("adPicture_id"));
		a.setAdPicture_path(rst.getString("adPicture_path"));
		a.setAdPicture_desc(rst.getString("adPicture_desc"));
		a.setAdPictureGroup_id(rst.getInt("adPictureGroup_id"));
		a.setUsers_id(rst.getInt("users_id"));
		return a;
	}

	//App
	public void modifyCount(int count, int id) throws ClassNotFoundException, SQLException {
		sql = "update adPicture set adPicture_count = ? where adPicture_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, count);
		pst.setInt(2, id);
		pst.execute();
		release();
	}
	
	/**
	 * 获取全部待机图片
	 */
	public ArrayList<AdPicture> getAllScollPicture() throws ClassNotFoundException, SQLException {
		ArrayList<AdPicture> list = new ArrayList<AdPicture>();
		sql = "select * from adPicture where adPictureGroup_id =4";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}
	
	/**
	 * 根据用户Id获取单个用户上传的待机图片
	 */
	public ArrayList<AdPicture> getScollPictureByUid(int uid) throws ClassNotFoundException, SQLException {
		ArrayList<AdPicture> list = new ArrayList<AdPicture>();
		sql = "select * from adPicture where adPictureGroup_id =4 and users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	/**
	 * 根据参数包含多个用户以,号分开，获得待机图片列表
	 */
	public List<AdPicture> getAllByUids(String userids) throws ClassNotFoundException, SQLException {
		ArrayList<AdPicture> list = new ArrayList<AdPicture>();
		sql = "select * from adPicture where adPictureGroup_id =4 and users_id in ("+userids+")";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

}