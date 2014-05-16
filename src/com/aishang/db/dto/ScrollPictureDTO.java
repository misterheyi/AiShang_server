package com.aishang.db.dto;

import java.util.List;

import com.aishang.db.DTOMain;
import com.aishang.vo.AdPictureVO;

public class ScrollPictureDTO extends DTOMain {

	private List<AdPictureVO> ad;

	public List<AdPictureVO> getAd() {
		return ad;
	}

	public void setAd(List<AdPictureVO> ad) {
		this.ad = ad;
	}
}
