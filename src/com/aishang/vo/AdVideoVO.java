package com.aishang.vo;

import com.aishang.db.bean.AdVideo;
import com.aishang.db.bean.Users;

public class AdVideoVO implements Comparable<AdVideoVO>{
	private AdVideo adVideo;
	private Users user;

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public AdVideo getAdVideo() {
		return adVideo;
	}

	public void setAdVideo(AdVideo adVideo) {
		this.adVideo = adVideo;
	}

	@Override
	public int compareTo(AdVideoVO o) {
		return this.user.getUserGroup_id()-o.getUser().getUserGroup_id();
	}

}
