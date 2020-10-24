package com.mvc.security.model.dto;

import java.util.Date;

public class BoardDto {
	
	private int bno;
	private String bname;
	private String btitle;
	private String bcontent;
	private Date bdate;
	
	public BoardDto() {}

	public BoardDto(int bno, String bname, String btitle, String bcontent, Date bdate) {
		super();
		this.bno = bno;
		this.bname = bname;
		this.btitle = btitle;
		this.bcontent = bcontent;
		this.bdate = bdate;
	}

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getBname() {
		return bname;
	}

	public void setBname(String bname) {
		this.bname = bname;
	}

	public String getBtitle() {
		return btitle;
	}

	public void setBtitle(String btitle) {
		this.btitle = btitle;
	}

	public String getBcontent() {
		return bcontent;
	}

	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}

	public Date getBdate() {
		return bdate;
	}

	public void setBdate(Date bdate) {
		this.bdate = bdate;
	}
	
	

}
