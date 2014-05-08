package com.aishang.test;

import java.sql.SQLException;

import com.aishang.db.dao.HairStyleDAO;

public class TestHairStyle {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		HairStyleDAO  dao = new HairStyleDAO();
		System.out.println(dao.getAllByUID_Limit(10004, 1, 10).size());
	}

}
