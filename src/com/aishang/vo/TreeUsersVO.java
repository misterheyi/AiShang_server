package com.aishang.vo;

import java.util.ArrayList;
import java.util.List;

import com.aishang.db.bean.Users;

public class TreeUsersVO{

	private Users parent;
	private List<TreeUsersVO> childs = new ArrayList<TreeUsersVO>();
	
	public Users getParent() {
		return parent;
	}
	public void setParent(Users parent) {
		this.parent = parent;
	}
	public List<TreeUsersVO> getChilds() {
		return childs;
	}
	public void setChilds(List<TreeUsersVO> childs) {
		this.childs = childs;
	}
	
}
