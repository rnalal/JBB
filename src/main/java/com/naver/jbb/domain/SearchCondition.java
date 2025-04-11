package com.naver.jbb.domain;

import java.util.Date;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {
	private Integer page = 1;
	private Integer pageSize = 3;
//	private Integer offset = 0;
	private String keyword = "";
	private String option = "";	
	private Integer category;
	private String writer;
	private String bc_name;
	private String startDate;
	private String endDate;
	private String reg_date;

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getBc_name() {
		return bc_name;
	}

	public void setBc_name(String bc_name) {
		this.bc_name = bc_name;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Integer getOffset() {
		return (page-1) * pageSize;
	}
	
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
	}
	
	public SearchCondition() {};
	public SearchCondition(Integer page, Integer pageSize, String keyword, String option) {
		this.page = page;
		this.pageSize = pageSize;
		this.keyword = keyword;
		this.option = option;
	}
	
	public String getQueryString(Integer page) {
	    UriComponentsBuilder builder = UriComponentsBuilder.newInstance();

	    // reg_date를 가장 먼저!
	    if (reg_date != null && !reg_date.isEmpty()) {
	        builder.queryParam("reg_date", reg_date);
	    }

	    // 나머지 파라미터들
	    builder.queryParam("page", page)
	           .queryParam("pageSize", pageSize);

	    if (option != null && !option.isEmpty()) {
	        builder.queryParam("option", option);
	    }
	    if (keyword != null && !keyword.isEmpty()) {
	        builder.queryParam("keyword", keyword);
	    }

	    return builder.build().toUriString();
	}
	
	public String getQueryString() {
		return getQueryString(page);
	}
		
	public Integer getPage() {
		return page;
	}
	public void setPage(Integer page) {
		this.page = page;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	
	@Override
	public String toString() {
		return "SearchCondition [page=" + page + ", pageSize=" + pageSize + ", offset=" + getOffset() + ", keyword="
				+ keyword + ", option=" + option + "]";
	}			
	
}
