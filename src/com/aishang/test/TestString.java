package com.aishang.test;

public class TestString {

	public static void main(String[] args) {
		String path = "xxx/upload/xx/xx";
		String fileName = path.substring(path.indexOf("upload") + 6);
		System.out.println(fileName);
	}
}
