package com.aishang.vo;

import com.aishang.db.bean.HairStyle;
import com.aishang.db.bean.Users;

public class HairStyleVO implements Comparable<HairStyleVO>{
	private Users user;
	private HairStyle hairStyle;

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public HairStyle getHairStyle() {
		return hairStyle;
	}

	public void setHairStyle(HairStyle hairStyle) {
		this.hairStyle = hairStyle;
	}

	@Override
	public int compareTo(HairStyleVO o) {
		return this.user.getUserGroup_id()-o.getUser().getUserGroup_id();
	}

	
}
