package com.aishang.db.dto;

import java.util.List;

import com.aishang.db.DTOMain;
import com.aishang.db.bean.AdPicture;
import com.aishang.db.bean.Users;

public class PriceListDTO extends DTOMain {
	private List<AdPicture> ad1;
	private List<AdPicture> ad2;
	private List<AdPicture> ad3;
	private List<AdPicture> ad4;
	private List<Users> hairstylist;

	public List<Users> getHairstylist() {
		return hairstylist;
	}

	public void setHairstylist(List<Users> hairstylist) {
		this.hairstylist = hairstylist;
	}

	public List<AdPicture> getAd1() {
		return ad1;
	}

	public void setAd1(List<AdPicture> ad1) {
		this.ad1 = ad1;
	}

	public List<AdPicture> getAd2() {
		return ad2;
	}

	public void setAd2(List<AdPicture> ad2) {
		this.ad2 = ad2;
	}

	public List<AdPicture> getAd3() {
		return ad3;
	}

	public void setAd3(List<AdPicture> ad3) {
		this.ad3 = ad3;
	}

	public List<AdPicture> getAd4() {
		return ad4;
	}

	public void setAd4(List<AdPicture> ad4) {
		this.ad4 = ad4;
	}
}
