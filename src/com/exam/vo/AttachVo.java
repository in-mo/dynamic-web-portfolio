package com.exam.vo;

public class AttachVo {
	private int num;
	private String image; 	// ���� ���ε�� ���ϸ�
	private String uploadpath; 	// ���� ���ε�� ���� ���
	private String reg_article;		 	// notice ���̺��� �۹�ȣ num
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
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
	public String getReg_article() {
		return reg_article;
	}
	public void setReg_article(String reg_article) {
		this.reg_article = reg_article;
	}
	
	@Override
	public String toString() {
		return "AttachVo [num=" + num + ", image=" + image + ", uploadpath=" + uploadpath + ", reg_article="
				+ reg_article + "]";
	}
}
