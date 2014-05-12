package com.aishang.db.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aishang.db.DBMain;
import com.aishang.db.bean.HairStyle;

public class HairStyleDAO extends DBMain<HairStyle> {

	@Override
	public ArrayList<HairStyle> getAll() throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	/**
	 * 获取发型库总数
	 */
	public int getHairStyleCount() throws ClassNotFoundException, SQLException {
		sql = "select count(*) from hairStyle";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}
	
	/**
	 * 获取发型师上传的发型库总数
	 */
	public int getHairStyleCountByUid(int uid) throws ClassNotFoundException, SQLException {
		sql = "select count(*) from hairStyle where users_id = ? ";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}
	
	/**
	 * 获取美发店的发型总数
	 */
	public int getStoreHairStyleCountByUid(int uid) throws ClassNotFoundException, SQLException {
		sql = "select count(*) from hairStyle where users_id = "+uid+" or users_id in (select users_id2 from userRelation where users_id ="+uid+") ";
		pst = getPrepareStatement(sql);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	/**
	 * 
	 */
	public ArrayList<HairStyle> getAllByGroup_LimitUid(String area, String desc, String height, String sex, int page,
			int count) throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle where hairStyle_area like ? and hairStyle_desc like ? and hairStyle_height like ? and hairStyle_sex like ? limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%" + area + "%");
		pst.setString(2, "%" + desc + "%");
		pst.setString(3, "%" + height + "%");
		pst.setString(4, "%" + sex + "%");
		pst.setInt(5, (page - 1) * count);
		pst.setInt(6, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}
	
	/**
	 * 获取美发店、超级管理员下所有发型
	 * @param area
	 * @param desc
	 * @param height
	 * @param sex
	 * @param page
	 * @param count
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	//App
	public ArrayList<HairStyle> getAllByGroup_LimitByUid(String area, String desc, String height, String sex, int page,
			int count,int uid) throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		List<Integer> hairStylesListIds = new UserRelationDAO().getUsersId2ByUid(uid);
		String user = String.valueOf(uid);
		
		List<Integer> managerIds = new UsersDAO().getManagerUserId();//获取管理员Id
		if(hairStylesListIds.size()>0){
			managerIds.addAll(hairStylesListIds);
		}
		
		for(Integer id:managerIds){
			user+=","+id;
		}
		sql = "select * from hairStyle where users_id in ("+user+") and hairStyle_area like ? and hairStyle_desc like ? and hairStyle_height like ? and hairStyle_sex like ? limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%" + area + "%");
		pst.setString(2, "%" + desc + "%");
		pst.setString(3, "%" + height + "%");
		pst.setString(4, "%" + sex + "%");
		pst.setInt(5, (page - 1) * count);
		pst.setInt(6, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}
	
	/**
	 * 发型师获取美发店所有发型
	 * @param area
	 * @param desc
	 * @param height
	 * @param sex
	 * @param page
	 * @param count
	 * @param uid
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public ArrayList<HairStyle> getUserByGroup_LimitByUid(String area, String desc, String height, String sex, int page,
			int count,int uid) throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		Integer userId = new UserRelationDAO().getUsersIdByUid2(uid);
		String user = String.valueOf(uid);
		user+=","+userId;
		sql = "select * from hairStyle where users_id in ("+user+") "+
				"and hairStyle_area like ? and hairStyle_desc like ? and hairStyle_height like ? and hairStyle_sex like ? limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%" + area + "%");
		pst.setString(2, "%" + desc + "%");
		pst.setString(3, "%" + height + "%");
		pst.setString(4, "%" + sex + "%");
		pst.setInt(5, (page - 1) * count);
		pst.setInt(6, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}
	
	/**
	 * 美发店获取所有发型师包括美发店管理员的发型
	 * @param area
	 * @param desc
	 * @param height
	 * @param sex
	 * @param page
	 * @param count
	 * @param uid
	 * @return
	 * @throws ClassNotFoundException
	 * @throws SQLException
	 */
	public ArrayList<HairStyle> getStoreByGroup_LimitByUid(String area, String desc, String height, String sex, int page,
			int count,int uid) throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		List<Integer> usersId = new UserRelationDAO().getUsersId2ByUid(uid);
		String user = String.valueOf(uid);
		if(usersId.size()>0){
			for(Integer id:usersId){
				user+=","+id;
			}
		}
		sql = "select * from hairStyle where users_id in ("+user+") "+
				"and hairStyle_area like ? and hairStyle_desc like ? and hairStyle_height like ? and hairStyle_sex like ? limit ?,?";
		pst = getPrepareStatement(sql);
		pst.setString(1, "%" + area + "%");
		pst.setString(2, "%" + desc + "%");
		pst.setString(3, "%" + height + "%");
		pst.setString(4, "%" + sex + "%");
		pst.setInt(5, (page - 1) * count);
		pst.setInt(6, count);
		rst = pst.executeQuery();
		while (rst.next()) {
			list.add(assemble(rst));
		}
		release();
		return list;
	}

	public int findIdByPath(String path) throws SQLException, ClassNotFoundException {
		sql = "select * from hairStyle where hairStyle_path = ?";
		pst = getPrepareStatement(sql);
		pst.setString(1, path);
		rst = pst.executeQuery();
		if (rst.next()) {
			HairStyle hairStyle = assemble(rst);
			release();
			return hairStyle.getHairStyle_id();
		}
		release();
		return 0;
	}

	/**
	 * 获取全部发型库带分页参数
	 */
	public ArrayList<HairStyle> getAllByLimit(int page, int count) throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle limit ?,?";
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
	 * 获取单个用户上传的发型库
	 */
	public ArrayList<HairStyle> getAllByUID(int uid) throws ClassNotFoundException, SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle where users_id = ?";
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
	 *获取单个发型师上传的发型库图片带分页 
	 */
	public ArrayList<HairStyle> getAllByUID_Limit(int uid, int page, int count) throws ClassNotFoundException,
			SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle where users_id = ? limit ?,?";
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

	public ArrayList<HairStyle> getAllByMark_Limit(int uid, int page, int count) throws ClassNotFoundException,
			SQLException {
		ArrayList<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle where hairStyle_id in (select hairStyle_id from markHairStyle where users_id = ?) limit ?,?";
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
	public HairStyle getById(int id) throws ClassNotFoundException, SQLException {
		sql = "select * from hairStyle where hairStyle_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		rst = pst.executeQuery();
		while (rst.next()) {
			HairStyle hairStyle = assemble(rst);
			release();
			return hairStyle;
		}
		release();
		return null;
	}

	/**
	 * 获取单个用户标识的发型库
	 */
	public int getCountByMark(int uid) throws ClassNotFoundException, SQLException {
		sql = "select count(*) from markHairStyle where users_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, uid);
		rst = pst.executeQuery();
		rst.next();
		int c = rst.getInt(1);
		release();
		return c;
	}

	@Override
	public void add(HairStyle obj) throws ClassNotFoundException, SQLException {
		sql = "insert into hairStyle(hairStyle_area,hairStyle_desc,hairStyle_height,hairStyle_path,hairStyle_sex,users_id) values(?,?,?,?,?,?)";
		pst = getPrepareStatement(sql);
		pst.setString(1, obj.getHairStyle_area());
		pst.setString(2, obj.getHairStyle_desc());
		pst.setString(3, obj.getHairStyle_height());
		pst.setString(4, obj.getHairStyle_path());
		pst.setString(5, obj.getHairStyle_sex());
		pst.setInt(6, obj.getUsers_id());
		pst.execute();
		release();
	}

	@Override
	public void modify(HairStyle obj) throws ClassNotFoundException, SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(HairStyle obj) throws ClassNotFoundException, SQLException {
		sql = "delete from hairStyle where hairStyle_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, obj.getHairStyle_id());
		pst.execute();
		release();
	}

	public void deleteById(int id) throws ClassNotFoundException, SQLException {
		sql = "delete from hairStyle where hairStyle_id = ?";
		pst = getPrepareStatement(sql);
		pst.setInt(1, id);
		pst.execute();
		release();
	}

	@Override
	public HairStyle assemble(ResultSet rst) throws SQLException {
		HairStyle h = new HairStyle();
		h.setHairStyle_area(rst.getString("hairStyle_area"));
		h.setHairStyle_desc(rst.getString("hairStyle_desc"));
		h.setHairStyle_height(rst.getString("hairStyle_height"));
		h.setHairStyle_id(rst.getInt("hairStyle_id"));
		h.setHairStyle_path(rst.getString("hairStyle_path"));
		h.setHairStyle_sex(rst.getString("hairStyle_sex"));
		h.setUsers_id(rst.getInt("users_id"));
		return h;
	}
	
	/**
	 * 获取美发店的发型
	 */
	public List<HairStyle> getStoreByLimit(int uid,int page,int count) throws ClassNotFoundException, SQLException {
		List<HairStyle> list = new ArrayList<HairStyle>();
		sql = "select * from hairStyle where users_id = "+uid+" or users_id in (select users_id2 from userRelation where users_id ="+uid+") limit ?,? ";
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

}
