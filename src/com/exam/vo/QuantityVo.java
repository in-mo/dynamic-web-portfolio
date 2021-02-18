package com.exam.vo;

public class QuantityVo {
	private int num;
	private String size;
	private int red;
	private int orange;
	private int yellow;
	private int green;
	private int blue;
	private String reg_article;

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public int getRed() {
		return red;
	}

	public void setRed(int red) {
		this.red = red;
	}

	public int getOrange() {
		return orange;
	}

	public void setOrange(int orange) {
		this.orange = orange;
	}

	public int getYellow() {
		return yellow;
	}

	public void setYellow(int yellow) {
		this.yellow = yellow;
	}

	public int getGreen() {
		return green;
	}

	public void setGreen(int green) {
		this.green = green;
	}

	public int getBlue() {
		return blue;
	}

	public void setBlue(int blue) {
		this.blue = blue;
	}

	public String getReg_article() {
		return reg_article;
	}

	public void setReg_article(String reg_article) {
		this.reg_article = reg_article;
	}

	@Override
	public String toString() {
		return "QuantityVo [num=" + num + ", size=" + size + ", red=" + red + ", orange=" + orange + ", yellow="
				+ yellow + ", green=" + green + ", blue=" + blue + ", reg_article=" + reg_article + "]";
	}
}
