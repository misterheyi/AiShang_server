package com.aishang.vo;

import com.aishang.db.bean.AdPicture;
import com.aishang.db.bean.Users;

public class AdPictureVO implements Comparable<AdPictureVO>{
	private AdPicture adPicture;
	private Users user;

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public AdPicture getAdPicture() {
		return adPicture;
	}

	public void setAdPicture(AdPicture adPicture) {
		this.adPicture = adPicture;
	}

	@Override
	public int compareTo(AdPictureVO o) {
		return this.user.getUserGroup_id()-o.getUser().getUserGroup_id();
	}

}
