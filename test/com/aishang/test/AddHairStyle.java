package com.aishang.test;

import java.sql.SQLException;
import java.util.Random;

import com.aishang.db.bean.HairStyle;
import com.aishang.db.dao.HairStyleDAO;

public class AddHairStyle {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		String[] sexs = { "女性", "男性" };
		String[] areas = { "亚洲", "欧洲" };
		String[] descs = { "活泼可爱", "端庄典雅", "优雅时尚", "新锐个性", "盘发扎发" };
		String[] heights = { "长", "中", "短" };

		HairStyleDAO dao = new HairStyleDAO();
		for (int i = 0; i < 100; i++) {
			HairStyle hairStyle = new HairStyle();
			Random random = new Random();
			hairStyle.setHairStyle_area(areas[random.nextInt(2)]);
			hairStyle.setHairStyle_desc(descs[random.nextInt(5)]);
			hairStyle.setHairStyle_height(heights[random.nextInt(3)]);
			hairStyle.setHairStyle_sex(sexs[random.nextInt(2)]);
			hairStyle.setHairStyle_path("upload/hairstyle/10004/d4f0cbf0-6d9f-402e-8c51-7026a75e7b82.png");
			hairStyle.setUsers_id(10004);
			dao.add(hairStyle);
		}

	}
}