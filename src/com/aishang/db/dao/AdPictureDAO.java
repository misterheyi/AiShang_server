package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.AdPicture;

public class AdPictureDAO extends DBMain<AdPicture> {

	@Override
	public ArrayList<AdPicture> getAll() throws ClassNotFoundException, SQLException {
		return null;
	}

	@Override
	public AdPicture getById(int id) throws ClassNotFoundException, SQLException {
		return null;
	}

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

	public ArrayList<AdPicture> getScollPicture(String id) throws ClassNotFoundException, SQLException {
		ArrayList<AdPicture> list = new ArrayList<AdPicture>();
		sql = "select * from adPicture where adPictureGroup_id =4 and users_id in (select users_id from users where userGroup_id <=2 union select urr.users_id from users u , userRelation ur, userRelation urr where ur.users_id=urr.users_id2 and ur.users_id2=u.users_id and u.users_id=?)";
		pst = getPrepareStatement(sql);
		pst.setString(1, id);
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

}