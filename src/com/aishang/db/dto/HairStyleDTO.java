package com.aishang.db.dto;

import java.util.List;

import com.aishang.db.DTOMain;
import com.aishang.db.bean.HairStyle;

public class HairStyleDTO extends DTOMain {
	private List<HairStyle> hairStyles;

	public List<HairStyle> getHairStyles() {
		return hairStyles;
	}

	public void setHairStyles(List<HairStyle> hairStyles) {
		this.hairStyles = hairStyles;
	}

}
