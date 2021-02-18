package com.exam.vo;

import java.sql.Timestamp;

public class OrderVo {
	private int order_num;
	private String article;
	private String id;
	private String size;
	private String color;
	private int quantity;
	private int price;
	private String name;
	private int age;
	private String gender;
	private String tel;
	private String absence_msg;
	private String address;
	private String delivery;
	private String expect_date;
	private Timestamp order_date;
	public int getOrder_num() {
		return order_num;
	}
	public void setOrder_num(int order_num) {
		this.order_num = order_num;
	}
	public String getArticle() {
		return article;
	}
	public void setArticle(String article) {
		this.article = article;
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
	public int getQuantity() {
		return quantity;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getName() {
		return name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAbsence_msg() {
		return absence_msg;
	}
	public void setAbsence_msg(String absence_msg) {
		this.absence_msg = absence_msg;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getExpect_date() {
		return expect_date;
	}
	public void setExpect_date(String expect_date) {
		this.expect_date = expect_date;
	}
	public Timestamp getOrder_date() {
		return order_date;
	}
	public void setOrder_date(Timestamp order_date) {
		this.order_date = order_date;
	}
	@Override
	public String toString() {
		return "OrderVo [order_num=" + order_num + ", article=" + article + ", id=" + id + ", size=" + size + ", color="
				+ color + ", quantity=" + quantity + ", price=" + price + ", name=" + name + ", age=" + age
				+ ", gender=" + gender + ", tel=" + tel + ", absence_msg=" + absence_msg + ", address=" + address
				+ ", delivery=" + delivery + ", expect_date=" + expect_date + ", order_date=" + order_date + "]";
	}
}
