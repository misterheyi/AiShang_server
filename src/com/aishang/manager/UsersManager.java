package com.aishang.manager;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aishang.db.bean.Users;
import com.aishang.db.dao.UserRelationDAO;
import com.aishang.db.dao.UsersDAO;
import com.aishang.vo.TreeUsersVO;

public class UsersManager {

	private UsersDAO usersDAO;
	
	public UsersManager(){
		if(usersDAO == null)usersDAO = new UsersDAO();
	}
	
	/**
	 * 查询超管和代理商的List
	 */
	public List<TreeUsersVO> getManagerAndStoreByPageCount(int pageNow,int pageSize) throws ClassNotFoundException, SQLException{
		List<TreeUsersVO> list = new ArrayList<TreeUsersVO>();
		List<Users> users = usersDAO.getManagerAndStoreByPageCount(pageNow, pageSize);
		
		TreeUsersVO treeUsersVO = null;
		if(users.size()>0){
			for(Users u:users){
				treeUsersVO = new TreeUsersVO();
				treeUsersVO.setParent(u);
				treeUsersVO.setChilds(convertTreeUsersVO(u.getUsers_id()));
				list.add(treeUsersVO);
			}
		}
		
		return list;
	}
	
	/**
	 * 带关键字查询超管和代理商的List,不返回分页
	 */
	public List<TreeUsersVO> getManagerAndStoreByPageCount(String keyWord) throws ClassNotFoundException, SQLException{
		List<TreeUsersVO> list = new ArrayList<TreeUsersVO>();
		List<Users> resultUsers = usersDAO.getUsersByKeyWord(keyWord);
		
		TreeUsersVO treeUsersVO = null;
		if(resultUsers.size()>0){
			for(Users u:resultUsers){
				treeUsersVO = convertSearchTreeUsersVO(u);
				list.add(treeUsersVO);
			}
		}
		
		return list;
	}

	private TreeUsersVO convertSearchTreeUsersVO(Users u) throws ClassNotFoundException, SQLException {
		
		int groupId = u.getUserGroup_id();
		int uid = u.getUsers_id();
		TreeUsersVO root = new TreeUsersVO();
		List<TreeUsersVO> list = null;
		if(groupId==1){
			//搜索用户结果为超管，没有子节点直接返回
			root.setParent(u);
			root.setChilds(new ArrayList<TreeUsersVO>());
		}else if(groupId==2){
			//搜索用户结果为代理商，遍历美发店和发型师
			list = convertTreeUsersVO(uid);
			root.setParent(u);
			root.setChilds(list);
		}else if(groupId==3){
			//搜索结果为美发店，取上级代理商，遍历发型师
			Users agent = usersDAO.getStoreByStylist(uid);
			List<TreeUsersVO> hairStylst = convertTreeUsersVO(uid);
			TreeUsersVO node = new TreeUsersVO();
			node.setParent(u);
			node.setChilds(hairStylst);
			
			List<TreeUsersVO> storeList = new ArrayList<TreeUsersVO>();
			storeList.add(node);
			root.setParent(agent);
			root.setChilds(storeList);
			
			
		}else if(groupId==4){
			//搜索结果为发型师，取上级美发店，再取上级代理商
			Users store = usersDAO.getStoreByStylist(uid);
			Users agent = usersDAO.getStoreByStylist(store.getUsers_id());
			
			TreeUsersVO subNode = new TreeUsersVO();
			subNode.setParent(u);
			subNode.setChilds(new ArrayList<TreeUsersVO>());
			
			List<TreeUsersVO> hairStylst = new ArrayList<TreeUsersVO>();
			hairStylst.add(subNode);
			
			TreeUsersVO node = new TreeUsersVO();
			node.setParent(store);
			node.setChilds(hairStylst);
			
			List<TreeUsersVO> storeList = new ArrayList<TreeUsersVO>();
			storeList.add(node);
			
			root.setParent(agent);
			root.setChilds(storeList);
		}
		
		return root;
	}

	//根据父节点继续获取子节点
	private List<TreeUsersVO> convertTreeUsersVO(int usersId) throws ClassNotFoundException, SQLException {
		List<TreeUsersVO> childs = new ArrayList<TreeUsersVO>();
		List<Users> users =usersDAO.getUsersByStoreId(usersId); 
		TreeUsersVO treeUsersVO = null;
		if(users.size()>0){
			for(Users u:users){
				treeUsersVO = new TreeUsersVO();
				treeUsersVO.setParent(u);
				treeUsersVO.setChilds(convertTreeUsersVO(u.getUsers_id()));
				childs.add(treeUsersVO);
			}
		}
		return childs;
	}
}
