package com.aishang.db.dto;

import com.aishang.db.DTOMain;
import com.aishang.db.bean.Users;

public class LoginDTO extends DTOMain {
	private Users hairstylist;
	private Users store;
	private Users agent;

	public Users getHairstylist() {
		return hairstylist;
	}

	public void setHairstylist(Users hairstylist) {
		this.hairstylist = hairstylist;
	}

	public Users getStore() {
		return store;
	}

	public void setStore(Users store) {
		this.store = store;
	}

	public Users getAgent() {
		return agent;
	}

	public void setAgent(Users agent) {
		this.agent = agent;
	}
	
	
}
