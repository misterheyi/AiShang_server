package com.aishang.db.dto;

import java.util.List;

import com.aishang.db.DTOMain;
import com.aishang.db.bean.AdVideo;
import com.aishang.vo.AdVideoVO;

public class AdVideoDTO extends DTOMain {
	private List<AdVideoVO> videos;

	public List<AdVideoVO> getVideos() {
		return videos;
	}

	public void setVideos(List<AdVideoVO> videos) {
		this.videos = videos;
	}

}
