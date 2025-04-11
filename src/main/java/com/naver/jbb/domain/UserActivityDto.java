package com.naver.jbb.domain;

public class UserActivityDto {
	private String id;
	private String name;
	private Integer login_count;
	private Integer board_count;
	private Integer comment_count;
	private Integer like_count;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getLogin_count() {
		return login_count;
	}
	public void setLogin_count(Integer login_count) {
		this.login_count = login_count;
	}
	public Integer getBoard_count() {
		return board_count;
	}
	public void setBoard_count(Integer board_count) {
		this.board_count = board_count;
	}
	public Integer getComment_count() {
		return comment_count;
	}
	public void setComment_count(Integer comment_count) {
		this.comment_count = comment_count;
	}
	public Integer getLike_count() {
		return like_count;
	}
	public void setLike_count(Integer like_count) {
		this.like_count = like_count;
	}
		
}
