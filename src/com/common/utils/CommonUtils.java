package com.common.utils;

import java.util.ArrayList;

import com.aishang.db.bean.MarkHairStyle;

public class CommonUtils {

	public static boolean searchM(int id, ArrayList<MarkHairStyle> list) {
		for (MarkHairStyle markHairStyle : list) {
			if (id == markHairStyle.getHairStyle_id()) {
				return true;
			}
		}
		return false;
	}
}
