package com.aishang.db.bean;

public class AdPicture {
	private int adPicture_id;
	private String adPicture_path;
	private String adPicture_desc;
	private int adPictureGroup_id;
	private int users_id;
	private int adPictureCount;

	public int getAdPictureCount() {
		return adPictureCount;
	}

	public void setAdPictureCount(int adPictureCount) {
		this.adPictureCount = adPictureCount;
	}

	public String getAdPicture_desc() {
		return adPicture_desc;
	}

	public void setAdPicture_desc(String adPicture_desc) {
		this.adPicture_desc = adPicture_desc;
	}

	public int getAdPicture_id() {
		return adPicture_id;
	}

	public int getAdPictureGroup_id() {
		return adPictureGroup_id;
	}

	public void setAdPictureGroup_id(int adPictureGroup_id) {
		this.adPictureGroup_id = adPictureGroup_id;
	}

	public void setAdPicture_id(int adPicture_id) {
		this.adPicture_id = adPicture_id;
	}

	public String getAdPicture_path() {
		return adPicture_path;
	}

	public void setAdPicture_path(String adPicture_path) {
		this.adPicture_path = adPicture_path;
	}

	public int getUsers_id() {
		return users_id;
	}

	public void setUsers_id(int users_id) {
		this.users_id = users_id;
	}
}
