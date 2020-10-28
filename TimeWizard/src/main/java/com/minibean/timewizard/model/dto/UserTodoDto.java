package com.minibean.timewizard.model.dto;

import java.util.Date;

public class UserTodoDto {
	
	private int todo_no;
	private int user_no;
	private String todo_title;
	private String todo_color;
	private String todo_content;
	private String todo_category;
	private String todo_hashtag;
	private Date todo_date;
	private String todo_complete;
	
	public UserTodoDto() {}

	public UserTodoDto(int todo_no, int user_no, String todo_title, String todo_color, String todo_content,
			String todo_category, String todo_hashtag, Date todo_date, String todo_complete) {
		super();
		this.todo_no = todo_no;
		this.user_no = user_no;
		this.todo_title = todo_title;
		this.todo_color = todo_color;
		this.todo_content = todo_content;
		this.todo_category = todo_category;
		this.todo_hashtag = todo_hashtag;
		this.todo_date = todo_date;
		this.todo_complete = todo_complete;
	}

	public int getTodo_no() {
		return todo_no;
	}

	public void setTodo_no(int todo_no) {
		this.todo_no = todo_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getTodo_title() {
		return todo_title;
	}

	public void setTodo_title(String todo_title) {
		this.todo_title = todo_title;
	}

	public String getTodo_color() {
		return todo_color;
	}

	public void setTodo_color(String todo_color) {
		this.todo_color = todo_color;
	}

	public String getTodo_content() {
		return todo_content;
	}

	public void setTodo_content(String todo_content) {
		this.todo_content = todo_content;
	}

	public String getTodo_category() {
		return todo_category;
	}

	public void setTodo_category(String todo_category) {
		this.todo_category = todo_category;
	}

	public String getTodo_hashtag() {
		return todo_hashtag;
	}

	public void setTodo_hashtag(String todo_hashtag) {
		this.todo_hashtag = todo_hashtag;
	}

	public Date getTodo_date() {
		return todo_date;
	}

	public void setTodo_date(Date todo_date) {
		this.todo_date = todo_date;
	}

	public String getTodo_complete() {
		return todo_complete;
	}

	public void setTodo_complete(String todo_complete) {
		this.todo_complete = todo_complete;
	}
	
	

}
