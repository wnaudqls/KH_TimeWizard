package com.minibean.timewizard.model.dto;

public class PayDto {
	
	private int user_no;
	private String pay_name;
	private int status;
	
	public PayDto() {
		
	}
	
	

	public PayDto(int user_no, String pay_name, int status) {
		super();
		this.user_no = user_no;
		this.pay_name = pay_name;
		this.status = status;
	}



	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getPay_name() {
		return pay_name;
	}

	public void setPay_name(String pay_name) {
		this.pay_name = pay_name;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	
	
	
}
