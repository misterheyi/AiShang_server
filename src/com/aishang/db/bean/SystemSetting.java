package com.aishang.db.bean;

public class SystemSetting {

	private int setting_id;
	private String setting_type;
	private String setting_value;
	
	public int getSetting_id() {
		return setting_id;
	}
	public void setSetting_id(int settingId) {
		setting_id = settingId;
	}
	public String getSetting_type() {
		return setting_type;
	}
	public void setSetting_type(String settingType) {
		setting_type = settingType;
	}
	public String getSetting_value() {
		return setting_value;
	}
	public void setSetting_value(String settingValue) {
		setting_value = settingValue;
	}
}
