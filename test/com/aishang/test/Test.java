package com.aishang.test;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.aishang.db.bean.AdPicture;
import com.aishang.db.dao.AdPictureDAO;

public class Test {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		AdPictureDAO dao = new AdPictureDAO();
		List<AdPicture> list = dao.getAllByUid(10003);
		System.out.println(list.size());
		List<AdPicture> ad1 = new ArrayList<AdPicture>();
		List<AdPicture> ad2 = new ArrayList<AdPicture>();
		List<AdPicture> ad3 = new ArrayList<AdPicture>();

		for (AdPicture adPicture : list) {
			switch (adPicture.getAdPictureGroup_id()) {
			case 1:
				ad1.add(adPicture);
				break;
			case 2:
				ad2.add(adPicture);
				break;
			case 3:
				ad3.add(adPicture);
				break;
			}
		}
		System.out.println(ad3.size());
	}
}
