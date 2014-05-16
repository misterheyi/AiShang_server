package com.aishang.manager;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import com.aishang.db.bean.AdVideo;
import com.aishang.db.bean.Users;
import com.aishang.db.dao.AdVideoDAO;
import com.aishang.db.dao.UserRelationDAO;
import com.aishang.db.dao.UsersDAO;
import com.aishang.vo.AdVideoVO;

public class AdVideoManager {

	private AdVideoDAO adVideoDAO = null;

	public AdVideoManager() {
		if (adVideoDAO == null) {
			adVideoDAO = new AdVideoDAO();
		}
	}

	/**
	 * 超管获取全部待机视频/点选视频
	 */
	public List<AdVideoVO> getAll() {
		List<AdVideoVO> list = new ArrayList<AdVideoVO>();
		try {
			List<AdVideo> adVideos = adVideoDAO.getAll();
			convertAdVideoVoList(list, adVideos);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 代理商获取自己及下属美发店待机视频/点选视频
	 */
	public List<AdVideoVO> getAgentVideoByUid(int uid){
		UserRelationDAO relationDAO = new UserRelationDAO();
		List<AdVideoVO> list = new ArrayList<AdVideoVO>();
		try {
			
			String userids = relationDAO.getChildIdsByUid(uid);
			if(userids.length()>0){
				userids = uid + "," + userids;
			}else{
				userids = String.valueOf(uid);
			}
				
			List<AdVideo> adVideos = adVideoDAO.getAllByUids(userids);
			convertAdVideoVoList(list, adVideos);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	private void convertAdVideoVoList(List<AdVideoVO> list,List<AdVideo> adVideos) throws ClassNotFoundException, SQLException {
		UsersDAO usersDAO = new UsersDAO();
		AdVideoVO adVideoVO;
		if(adVideos.size()>0){
			for(AdVideo adVideo:adVideos){
				adVideoVO = new AdVideoVO();
				adVideoVO.setAdVideo(adVideo);
				adVideoVO.setUser(usersDAO.getById(adVideo.getUsers_id()));
				list.add(adVideoVO);
			}
		}
		Collections.sort(list);
	}
	
	/**
	 * 获取美发店上传视频
	 * @return
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public List<AdVideoVO> getStoreVideoByUid(int uid) throws ClassNotFoundException, SQLException{
		List<AdVideoVO> list = new ArrayList<AdVideoVO>();
		List<AdVideo> adVideos = adVideoDAO.getVideoByUid(uid);
		convertAdVideoVoList(list, adVideos);
		return list;
	}

	/**
	 * App
	 * 根据代理商Id和美发店Id获取上传视频（包括超管）
	 * @param agentId
	 * @param storeId
	 * @return
	 * @throws SQLException 
	 * @throws ClassNotFoundException 
	 */
	public List<AdVideoVO> getAllByUid(Integer agentId, Integer storeId) throws ClassNotFoundException, SQLException {
		List<AdVideoVO> list = new ArrayList<AdVideoVO>();
		List<AdVideo> adVideos = adVideoDAO.getAllByUid(agentId,storeId);
		convertAdVideoVoList(list, adVideos);
		return list;
	}

}
