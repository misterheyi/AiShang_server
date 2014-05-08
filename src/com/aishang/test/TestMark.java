package com.aishang.test;

import java.sql.SQLException;

import com.aishang.db.bean.MarkHairStyle;
import com.aishang.db.dao.MarkHairStyleDAO;

public class TestMark {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		MarkHairStyle hairStyle = new MarkHairStyle();
		hairStyle.setHairStyle_id(1);
		hairStyle.setUsers_id(1);
		new MarkHairStyleDAO().add(hairStyle);
	}
}
