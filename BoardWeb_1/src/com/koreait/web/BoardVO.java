package com.koreait.web;

public class BoardVO {
	private int i_board;
	private String title;
	private String ctnt;
	private int i_student;
	
	
	public int getI_board() {
		return i_board;
	}
	public void setI_board(int i_board) {
		this.i_board = i_board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCtnt() {
		return ctnt;
	}
	public void setCtnt(String ctnt) {
		this.ctnt = ctnt;
	}
	public int getI_student() {
		return i_student;
	}
	public void setI_student(int i_student) {
		this.i_student = i_student;
	}
}