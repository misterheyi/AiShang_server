package com.aishang.manager;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import com.aishang.db.bean.AdPicture;
import com.aishang.db.bean.AdVideo;
import com.aishang.db.dao.AdPictureDAO;
import com.aishang.db.dao.UserRelationDAO;
import com.aishang.db.dao.UsersDAO;
import com.aishang.vo.AdPictureVO;
import com.aishang.vo.AdVideoVO;

public class AdPictureManager {

	private AdPictureDAO adPictureDAO;

	public AdPictureManager(){
		if(adPictureDAO==null){
			adPictureDAO = new AdPictureDAO();
		}
	}
	
	/**
	 * 超管获取全部待机图片
	 * @return
	 */
	public List<AdPictureVO> getAllScollPicture(){
		List<AdPictureVO> list = new ArrayList<AdPictureVO>();
		try {
			List<AdPicture> adPictures = adPictureDAO.getAllScollPicture();
			convertAdPictureVoList(list, adPictures);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	private void convertAdPictureVoList(List<AdPictureVO> list, List<AdPicture> adPictures)
			throws ClassNotFoundException, SQLException {
		UsersDAO usersDAO = new UsersDAO();
		AdPictureVO adPictureVo;
		if(adPictures.size()>0){
			for(AdPicture vo:adPictures){
				adPictureVo = new AdPictureVO();
				adPictureVo.setAdPicture(vo);
				adPictureVo.setUser(usersDAO.getById(vo.getUsers_id()));
				list.add(adPictureVo);
			}
		}
		Collections.sort(list);
	}
	
	/**
	 * 获取美发店待机图片
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public List<AdPictureVO> getStoreScrollPictureByUid(int uid) throws ClassNotFoundException, SQLException{
		List<AdPictureVO> list = new ArrayList<AdPictureVO>();
		List<AdPicture> adPictures = adPictureDAO.getScollPictureByUid(uid);
		convertAdPictureVoList(list, adPictures);
		return list;
	}
	
	/**
	 * 代理商获取自己及下属美发店待机图片
	 */
	public List<AdPictureVO> getAgentScollPictureByUid(int uid){
		UserRelationDAO relationDAO = new UserRelationDAO();
		List<AdPictureVO> list = new ArrayList<AdPictureVO>();
		try {
			
			String userids = relationDAO.getChildIdsByUid(uid);
			if(userids.length()>0){
				userids = uid + "," + userids;
			}else{
				userids = String.valueOf(uid);
			}
				
			List<AdPicture> adVideos = adPictureDAO.getAllByUids(userids);
			convertAdPictureVoList(list, adVideos);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
}
