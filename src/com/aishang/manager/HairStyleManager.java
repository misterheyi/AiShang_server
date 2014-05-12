package com.aishang.manager;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.aishang.db.bean.HairStyle;
import com.aishang.db.dao.HairStyleDAO;
import com.aishang.db.dao.UsersDAO;
import com.aishang.vo.HairStyleVO;

public class HairStyleManager {

	private HairStyleDAO hairStyleDAO;

	public HairStyleManager(){
		if(hairStyleDAO==null){
			hairStyleDAO = new HairStyleDAO();
		}
	}
	
	/**
	 * 超管获取全部发型库图片带分页参数
	 */
	public List<HairStyleVO> getAllByLimit(int pageNow,int pageSize) throws ClassNotFoundException, SQLException{
		List<HairStyleVO> list = new ArrayList<HairStyleVO>();
		
		try {
			List<HairStyle> hairStyles = hairStyleDAO.getAllByLimit(pageNow, pageSize);
			convertHairStyleVoList(list, hairStyles);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 *获取单个发型师上传的发型库图片带分页 
	 */
	public List<HairStyleVO> getAllByUID_Limit(int uid,int pageNow,int pageSize){
		List<HairStyleVO> list = new ArrayList<HairStyleVO>();
		
		try {
			List<HairStyle> hairStyles = hairStyleDAO.getAllByUID_Limit(uid,pageNow, pageSize);
			convertHairStyleVoList(list, hairStyles);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 *获取美发店所有发型师上传的发型库图片带分页 
	 */
	public List<HairStyleVO> getStoreByLimit(int uid,int pageNow,int pageSize){
		List<HairStyleVO> list = new ArrayList<HairStyleVO>();
		
		try {
			List<HairStyle> hairStyles = hairStyleDAO.getStoreByLimit(uid,pageNow, pageSize);
			convertHairStyleVoList(list, hairStyles);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	private void convertHairStyleVoList(List<HairStyleVO> list,
			List<HairStyle> hairStyles) throws ClassNotFoundException, SQLException {
		UsersDAO usersDAO = new UsersDAO();
		HairStyleVO hairStyleVO;
		if(hairStyles.size()>0){
			for(HairStyle vo:hairStyles){
				hairStyleVO = new HairStyleVO();
				hairStyleVO.setHairStyle(vo);
				hairStyleVO.setUser(usersDAO.getById(vo.getUsers_id()));
				list.add(hairStyleVO);
			}
		}
		Collections.sort(list);
	}
}
