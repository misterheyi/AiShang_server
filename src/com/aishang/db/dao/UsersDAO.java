package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aishang.db.DBMain;
import com.aishang.db.bean.Users;

public class UsersDAO extends DBMain<Users> {

	@Override
	public ArrayList<Users> getAll() throws ClassNotFoundException, SQLException {
		ArrayList<Users> list = new ArrayList<Users>();
		sql = "select * from users";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	//App
	/**
	 * 根据子节点Id找到父节点对象
	 */
	public Users getStoreByStylist(int id) throws ClassNotFoundException, SQLException {
		sql = "select * from users where users_id = (select users_id from userRelation where users_id2 = ?)";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		if (rst.next()) {
			Users user = assemble(rst);
			release();
			return user;
		}
		release();
		return null;
	}

	//App
	/**
	 * 根据父节点获取子节点Users集合
	 */
	public List<Users> getUsersByStoreId(int id) throws ClassNotFoundException, SQLException {
		List<Users> list = new ArrayList<Users>();
		sql = "select * from users where users_id in (select users_id2 from userRelation where users_id = ?)";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	public boolean findEmail(String email) throws SQLException, ClassNotFoundException {
		sql = "select * from users where users_email = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, email);
		rst = pst.executeQuery();
		if (rst.next()) {
			release();
			return true;
		}
		release();
		return false;
	}

	public ArrayList<Users> getAllByPageCount(int page, int count) throws SQLException, ClassNotFoundException {
		ArrayList<Users> list = new ArrayList<Users>();
		sql = "select * from users limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, (page - 1) * count);
		pst.setInt(2, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	/**
	 * 获取超管和代理商
	 */
	public ArrayList<Users> getManagerAndStoreByPageCount(int page, int count) throws SQLException,
			ClassNotFoundException {
		ArrayList<Users> list = new ArrayList<Users>();
		sql = "select * from users where userGroup_id <=2 order by userGroup_id asc limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, (page - 1) * count);
		pst.setInt(2, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}
	
	/**
	 * 带关键字查询超管和代理商
	 */
	public ArrayList<Users> getManagerAndStoreByPageCount(String keyWord,int page, int count) throws SQLException,
			ClassNotFoundException {
		ArrayList<Users> list = new ArrayList<Users>();
		sql = "select * from users where userGroup_id <=2 and (users_name like ? or users_email like ?) order by userGroup_id asc limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%"+keyWord+"%");
		pst.setString(2, "%"+keyWord+"%");
		pst.setInt(3, (page - 1) * count);
		pst.setInt(4, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	/**
	 * 获取美发店
	 */
	public ArrayList<Users> getStoreByPageCount(int page, int count) throws SQLException, ClassNotFoundException {
		ArrayList<Users> list = new ArrayList<Users>();
		sql = "select * from users where userGroup_id = 3 limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, (page - 1) * count);
		pst.setInt(2, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	/**
	 * 获取美发店，工作人员
	 */
	public ArrayList<Users> getHairStylistByPageCount(int uid, int page, int count) throws SQLException,
			ClassNotFoundException {
		ArrayList<Users> list = new ArrayList<Users>();
		sql = "select * from users where users_id in (select users_id2 from userRelation where users_id = ?) limit ?,?";
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
	public Users getById(int id) throws ClassNotFoundException, SQLException {
		sql = "select * from users where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		if (rst.next()) {
			Users users = assemble(rst);
			release();
			return users;
		}
		release();
		return null;
	}

	@Override
	public void add(Users obj) throws ClassNotFoundException, SQLException {
		sql = "insert into users(userGroup_id,users_IMEI,users_name,users_email,users_password,users_face) values(?,?,?,?,?,?)";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getUserGroup_id());
		pst.setString(2, obj.getUsers_IMEI());
		pst.setString(3, obj.getUsers_name());
		pst.setString(4, obj.getUsers_email());
		pst.setString(5, obj.getUsers_password());
		pst.setString(6, obj.getUsers_face());
		pst.execute();
		release();
	}

	@Override
	public void modify(Users obj) throws ClassNotFoundException, SQLException {
		sql = "update users set users_name = ?, users_email = ?, users_password = ?, users_IMEI = ?, userGroup_id = ? where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getUsers_name());
		pst.setString(2, obj.getUsers_email());
		pst.setString(3, obj.getUsers_password());
		if(obj.getUsers_IMEI()==null||"".equals(obj.getUsers_IMEI())){
			pst.setString(4, "");
		}else{
			pst.setString(4, obj.getUsers_IMEI());
		}
		pst.setInt(5, obj.getUserGroup_id());
		pst.setInt(6, obj.getUsers_id());
		pst.execute();
		release();
	}

	public void modifyFace(Users obj) throws ClassNotFoundException, SQLException {
		sql = "update users set users_face = ? where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getUsers_face());
		pst.setInt(2, obj.getUsers_id());
		pst.execute();
		release();
	}

	@Override
	public void delete(Users obj) throws ClassNotFoundException, SQLException {
		sql = "delete from users where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getUsers_id());
		pst.execute();
		release();
	}

	public Users findUser(String email, String password) throws ClassNotFoundException, SQLException {
		sql = "select * from users where users_email = ? and users_password = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, email);
		pst.setString(2, password);
		rst = pst.executeQuery();
		if (rst.next()) {
			Users users = assemble(rst);
			release();
			return users;
		}
		release();
		return null;
	}

	//App
	public Users findUser(String email, String password, String imei) throws ClassNotFoundException, SQLException {
		sql = "select * from users where userGroup_id = 4 and users_email = ? and users_password = ? and users_IMEI like '%'";
		pst = getPrepareStatement(sql);
		pst.setString(1, email);
		pst.setString(2, password);
		// pst.setString(3, imei);
		rst = pst.executeQuery();
		if (rst.next()) {
			Users users = assemble(rst);
			release();
			return users;
		}
		release();
		return null;
	}

	public int getManagerAndStoreCount() throws ClassNotFoundException, SQLException {
		sql = "select count(*) from users where userGroup_id <=2";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}
	
	public int getManagerAndStoreCountByKeyword(String keyword) throws ClassNotFoundException, SQLException {
		sql = "select count(*) from users where userGroup_id <=2 and (users_name like ? or users_email like ?)";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%"+keyword+"%");
		pst.setString(2, "%"+keyword+"%");
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	public int getManagerCount() throws ClassNotFoundException, SQLException {
		sql = "select count(*) from users where userGroup_id = 2";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	public int getStoreCount() throws ClassNotFoundException, SQLException {
		sql = "select count(*) from users where userGroup_id = 3";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}
	
	public int getStoreCount(int users_id) throws ClassNotFoundException, SQLException {
		sql = "SELECT COUNT( * ) FROM  userRelation WHERE users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, users_id);
		rst = pst.executeQuery();
		int c = 0;
		if(rst.next()){
			c = rst.getInt(1);
		}
		release();
		return c;
	}

	public int getHairStylistCount() throws ClassNotFoundException, SQLException {
		sql = "select count(*) from users where userGroup_id = 4";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}
	
	public int getAgentCount() throws ClassNotFoundException, SQLException {
		sql = "select count(*) from users where userGroup_id = 2";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	public int getHairStylistCountByMyStore(int id) throws ClassNotFoundException, SQLException {
		sql = "select count(*) from userRelation where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}
	
	public int getHairStylistCountByAgent(int id) throws ClassNotFoundException, SQLException {
		sql = "select count(*) from userRelation where users_id in (select users_id2 from userRelation where users_id = ?) ";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	public int getGroupID(int uid) throws ClassNotFoundException, SQLException {
		sql = "select userGroup_id from users where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	@Override
	public Users assemble(ResultSet rst) throws SQLException {
		Users u = new Users();
		u.setUserGroup_id(rst.getInt("userGroup_id"));
		u.setUsers_id(rst.getInt("users_id"));
		u.setUsers_email(rst.getString("users_email"));
		u.setUsers_IMEI(rst.getString("users_IMEI"));
		u.setUsers_name(rst.getString("users_name"));
		u.setUsers_password(rst.getString("users_password"));
		u.setUsers_face(rst.getString("users_face"));
		return u;
	}

	public List<Integer> getManagerUserId()throws ClassNotFoundException, SQLException  {
		ArrayList<Integer> list = new ArrayList<Integer>();
		sql = "select * from users where userGroup_id =1";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(rst.getInt("users_id"));
		}
		release();
		return list;
	}

	/**
	 *根据关键字获取搜索出的用户结果集 
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public List<Users> getUsersByKeyWord(String keyWord) throws SQLException, ClassNotFoundException {
		List<Users> list = new ArrayList<Users>();
		sql = "select * from users where users_name like ? or users_email like ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%"+keyWord+"%");
		pst.setString(2, "%"+keyWord+"%");
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

}