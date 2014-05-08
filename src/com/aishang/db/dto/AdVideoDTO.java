package com.aishang.db.dto;

import java.util.List;

import com.aishang.db.DTOMain;
import com.aishang.db.bean.AdVideo;

public class AdVideoDTO extends DTOMain {
	private List<AdVideo> videos;

	public List<AdVideo> getVideos() {
		return videos;
	}

	public void setVideos(List<AdVideo> videos) {
		this.videos = videos;
	}

}
