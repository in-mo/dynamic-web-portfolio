package com.exam.vo;

public class LikeVo {
	private int num;
	private String id;
	private String article;
	private String islike;
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
	public String getArticle() {
		return article;
	}
	public void setArticle(String article) {
		this.article = article;
	}
	public String getIslike() {
		return islike;
	}
	public void setIslike(String islike) {
		this.islike = islike;
	}
	@Override
	public String toString() {
		return "LikeVo [num=" + num + ", id=" + id + ", article=" + article + ", islike=" + islike + "]";
	}
}
