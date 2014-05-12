package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.aishang.db.DBMain;
import com.aishang.db.bean.UserRelation;

public class UserRelationDAO extends DBMain<UserRelation> {

	@Override
	public ArrayList<UserRelation> getAll() throws ClassNotFoundException, SQLException {

		return null;
	}

	public ArrayList<UserRelation> getAllByUid(int uid, int page, int count) throws ClassNotFoundException,
			SQLException {
		ArrayList<UserRelation> list = new ArrayList<UserRelation>();
		sql = "select * from userRelation where users_id = ? limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		pst.setInt(2, (page - 1) * count);
		pst.setInt(3, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	@Override
	public UserRelation getById(int id) throws ClassNotFoundException, SQLException {

		return null;
	}

	@Override
	public void add(UserRelation obj) throws ClassNotFoundException, SQLException {
		sql = "insert into userRelation(users_id,users_id2) select ?,? from dual where not exists(select * from userRelation where users_id=? and users_id2 =?)";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getUsers_id());
		pst.setInt(2, obj.getUsers_id2());
		pst.setInt(3, obj.getUsers_id());
		pst.setInt(4, obj.getUsers_id2());
		pst.execute();
		release();
	}

	@Override
	public void modify(UserRelation obj) throws ClassNotFoundException, SQLException {

	}

	@Override
	public void delete(UserRelation obj) throws ClassNotFoundException, SQLException {

	}

	public void deleteByUID(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from userRelation where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	public void deleteByUID2(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from userRelation where users_id2 = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	@Override
	public UserRelation assemble(ResultSet rst) throws SQLException {
		UserRelation u = new UserRelation();
		u.setUserRelation_id(rst.getInt("userRelation_id"));
		u.setUsers_id(rst.getInt("users_id"));
		u.setUsers_id2(rst.getInt("users_id2"));
		return u;
	}
	
	public ArrayList<Integer> getUsersId2ByUid(int uid) throws ClassNotFoundException,
		SQLException {
	ArrayList<Integer> list = new ArrayList<Integer>();
	sql = "select * from userRelation where users_id = ?";
	pst = getPrepareStatement(sql);
	pst.setInt(1, uid);
	rst = pst.executeQuery();
	while (rst.next()) {
		list.add(rst.getInt("users_id2"));
	}
	release();
	return list;
	}
	
	public int getUsersIdByUid2(int uid2) throws ClassNotFoundException,
	SQLException {
		sql = "select * from userRelation where users_id2 = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid2);
		rst = pst.executeQuery();
		if (rst.next()) {
			return rst.getInt("users_id");
		}
		release();
		return 0;
	}
	
	
	/**
	 *根据父节点获取子节点，多个子节点以,号隔开 
	 */
	public String getChildIdsByUid (int uid) throws ClassNotFoundException,
	SQLException {
		StringBuffer sb = new StringBuffer();
		int count = 0;
		sql = "select * from userRelation where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		while (rst.next()) {
			if(count==0){
				sb.append(rst.getInt("users_id2"));
			}else{
				sb.append(",").append(rst.getInt("users_id2"));
			}
			count++;
		}
		release();
		return sb.toString();
	}

}
