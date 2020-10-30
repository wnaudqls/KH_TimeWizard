package com.minibean.timewizard.model.dto;

public class Search extends PagingDto {
	private String searchType;
	private String keyword;
	
	public Search(String searchType, String keyword) {
		this.searchType = searchType;
		this.keyword = keyword;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
}
