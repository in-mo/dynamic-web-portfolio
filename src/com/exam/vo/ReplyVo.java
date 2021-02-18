package com.exam.vo;

import java.sql.Timestamp;

public class ReplyVo {
	private int num;
	private String id;
	private String image;
	private String uploadpath;
	private String article;
	private String content;
	private String grade;
	private Timestamp reg_date;
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getUploadpath() {
		return uploadpath;
	}
	public void setUploadpath(String uploadpath) {
		this.uploadpath = uploadpath;
	}
	public String getArticle() {
		return article;
	}
	public void setArticle(String article) {
		this.article = article;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "ReplyVo [num=" + num + ", id=" + id + ", image=" + image + ", uploadpath=" + uploadpath + ", article="
				+ article + ", content=" + content + ", grade=" + grade + ", reg_date=" + reg_date + "]";
	}
}
