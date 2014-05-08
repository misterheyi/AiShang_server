package com.aishang.exception;

public class MyException extends Exception {
	String note;

	public MyException(String note) {
		this.note = note;
	}

	public String getNote() {
		return note;
	}

	private static final long serialVersionUID = 1L;

}
