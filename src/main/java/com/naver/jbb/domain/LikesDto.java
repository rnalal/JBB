package com.naver.jbb.domain;

public class LikesDto {
	private Integer id;
	private String user_id;
	private Integer board_bno;
	
	public LikesDto() {}
	public LikesDto(Integer id, String user_id, Integer board_bno) {
		this.id = id;
		this.user_id = user_id;
		this.board_bno = board_bno;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getBoard_bno() {
		return board_bno;
	}
	public void setBoard_bno(Integer board_bno) {
		this.board_bno = board_bno;
	}
	
	@Override
	public String toString() {
		return "LikesDto [id=" + id + ", user_id=" + user_id + ", board_bno=" + board_bno + "]";
	}	
}
