package com.aishang.test;

public class TestTag {
	public static void main(String[] args) {
		String[] areas = { "", "" };
		String[] areas2 = { "亚洲", "欧洲" };
		System.out.println(areas);
		System.out.println(areas2);
		for (int i = 0; i < areas2.length; i++) {
			areas[i] =areas2[i];
		}
		System.out.println(areas);
		System.out.println(areas2);
	}
}
