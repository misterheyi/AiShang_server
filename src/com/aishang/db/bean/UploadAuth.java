package com.aishang.db.bean;


public class UploadAuth{

	private int auth_id;
	private int users_id;
	private int allow_video_num;	//允许上传待机视频数量
	private int allow_picture_num;	//允许上传待机图片数量
	private int used_video_num;		//已经上传视频数量
	private int used_picture_num;	//已经待机图片数量
	private String is_open = "0";			//是否开通访问上传页面权限,1为开通，0为未开通
	
	public String getIs_open() {
		return is_open;
	}
	public void setIs_open(String isOpen) {
		is_open = isOpen;
	}
	public int getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(int authId) {
		auth_id = authId;
	}
	public int getUsers_id() {
		return users_id;
	}
	public void setUsers_id(int usersId) {
		users_id = usersId;
	}
	public int getAllow_video_num() {
		return allow_video_num;
	}
	public void setAllow_video_num(int allowVideoNum) {
		allow_video_num = allowVideoNum;
	}
	public int getAllow_picture_num() {
		return allow_picture_num;
	}
	public void setAllow_picture_num(int allowPictureNum) {
		allow_picture_num = allowPictureNum;
	}
	public int getUsed_video_num() {
		return used_video_num;
	}
	public void setUsed_video_num(int usedVideoNum) {
		used_video_num = usedVideoNum;
	}
	public int getUsed_picture_num() {
		return used_picture_num;
	}
	public void setUsed_picture_num(int usedPictureNum) {
		used_picture_num = usedPictureNum;
	}
	
	
}
