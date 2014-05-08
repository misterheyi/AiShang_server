package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.MarkHairStyle;

public class MarkHairStyleDAO extends DBMain<MarkHairStyle> {

	@Override
	public ArrayList<MarkHairStyle> getAll() throws ClassNotFoundException, SQLException {

		return null;
	}

	public ArrayList<MarkHairStyle> getAllByUid(int uid) throws ClassNotFoundException, SQLException {
		ArrayList<MarkHairStyle> list = new ArrayList<MarkHairStyle>();
		sql = "select * from markHairStyle where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	@Override
	public MarkHairStyle getById(int id) throws ClassNotFoundException, SQLException {

		return null;
	}

	@Override
	public void add(MarkHairStyle obj) throws ClassNotFoundException, SQLException {
		sql = "insert into markHairStyle(users_id,hairStyle_id) select ?,? FROM dual WHERE not exists (select * from markHairStyle where markHairStyle.users_id = ? and markHairStyle.hairStyle_id = ?)";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getUsers_id());
		pst.setInt(2, obj.getHairStyle_id());
		pst.setInt(3, obj.getUsers_id());
		pst.setInt(4, obj.getHairStyle_id());
		pst.execute();
		release();
	}

	@Override
	public void modify(MarkHairStyle obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public void delete(MarkHairStyle obj) throws ClassNotFoundException, SQLException {
		sql = "delete from markHairStyle where markHairStyle_id = ?";
	}

	public void deleteById(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from markHairStyle where markHairStyle_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	public void deleteByHId(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from markHairStyle where hairStyle_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	public int getCountByUID(int id) throws SQLException, ClassNotFoundException {
		sql = "select count(*) from markHairStyle where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	@Override
	public MarkHairStyle assemble(ResultSet rst) throws SQLException {
		MarkHairStyle m = new MarkHairStyle();
		m.setHairStyle_id(rst.getInt("hairStyle_id"));
		m.setMarkHairStyle_id(rst.getInt("markHairStyle_id"));
		m.setUsers_id(rst.getInt("users_id"));
		return m;
	}

}
