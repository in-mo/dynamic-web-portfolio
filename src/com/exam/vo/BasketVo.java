package com.exam.vo;

import java.sql.Timestamp;

public class BasketVo {
	private int num;
	private String id;
	private String size;
	private String color;
	private int quantity;
	private String article;
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
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getArticle() {
		return article;
	}
	public void setArticle(String article) {
		this.article = article;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	@Override
	public String toString() {
		return "BasketVo [num=" + num + ", id=" + id + ", size=" + size + ", color=" + color + ", quantity=" + quantity
				+ ", article=" + article + ", reg_date=" + reg_date + "]";
	}
}
