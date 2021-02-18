package com.exam.vo;

import java.sql.Timestamp;

public class NoticeVo {
	private String article;
	private String limitedSale;
	private String brand;
	private String product;
	private String gender;
	private String part;
	private String detail;
	private int price;
	private int sale;
	private String delivery;
	private float releasedate;
	private String weekend;
	private int readcount;
	private int salecount;
	private int likecount;
	private float grade;
	private float avg_age;
	private Timestamp reg_date;
	
	private AttachVo attachVo;
	
	public String getArticle() {
		return article;
	}
	public void setArticle(String article) {
		this.article = article;
	}
	public String getLimitedSale() {
		return limitedSale;
	}
	public void setLimitedSale(String limitedSale) {
		this.limitedSale = limitedSale;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSale() {
		return sale;
	}
	public void setSale(int sale) {
		this.sale = sale;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public float getReleasedate() {
		return releasedate;
	}
	public void setReleasedate(float releasedate) {
		this.releasedate = releasedate;
	}
	public String getWeekend() {
		return weekend;
	}
	public void setWeekend(String weekend) {
		this.weekend = weekend;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public int getSalecount() {
		return salecount;
	}
	public void setSalecount(int salecount) {
		this.salecount = salecount;
	}
	public int getLikecount() {
		return likecount;
	}
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	public float getGrade() {
		return grade;
	}
	public void setGrade(float grade) {
		this.grade = grade;
	}
	public float getAvg_age() {
		return avg_age;
	}
	public void setAvg_age(float avg_age) {
		this.avg_age = avg_age;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	public AttachVo getAttachVo() {
		return attachVo;
	}
	public void setAttachVo(AttachVo attachVo) {
		this.attachVo = attachVo;
	}
	@Override
	public String toString() {
		return "NoticeVo [article=" + article + ", limitedSale=" + limitedSale + ", brand=" + brand + ", product="
				+ product + ", gender=" + gender + ", part=" + part + ", detail=" + detail + ", price=" + price
				+ ", sale=" + sale + ", delivery=" + delivery + ", releasedate=" + releasedate + ", weekend=" + weekend
				+ ", readcount=" + readcount + ", salecount=" + salecount + ", likecount=" + likecount + ", grade="
				+ grade + ", avg_age=" + avg_age + ", reg_date=" + reg_date + ", attachVo=" + attachVo + "]";
	}
}
