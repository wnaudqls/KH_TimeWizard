package com.mvc.security.model.dto;

public class MemberDto {

	private int mno;
	private String mid;
	private String mpw;
	private String mname;
	private String mrole;
	private String menabled;
	
	public MemberDto() {}

	public MemberDto(int mno, String mid, String mpw, String mname, String mrole, String menabled) {
		super();
		this.mno = mno;
		this.mid = mid;
		this.mpw = mpw;
		this.mname = mname;
		this.mrole = mrole;
		this.menabled = menabled;
	}

	public int getMno() {
		return mno;
	}

	public void setMno(int mno) {
		this.mno = mno;
	}

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getMpw() {
		return mpw;
	}

	public void setMpw(String mpw) {
		this.mpw = mpw;
	}

	public String getMname() {
		return mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	public String getMrole() {
		return mrole;
	}

	public void setMrole(String mrole) {
		this.mrole = mrole;
	}

	public String getMenabled() {
		return menabled;
	}

	public void setMenabled(String menabled) {
		this.menabled = menabled;
	}
	
}
