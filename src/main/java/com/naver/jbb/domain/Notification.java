package com.naver.jbb.domain;

import java.util.Date;

public class Notification {
	private Integer id;
	private String recipient; //알림 받는 사용자 ID
	private String type; //"COMMENT" or "LIKE"
	private String message; //"JBB님이 댓글을 남겼습니다."
	private String url; //"/board/detail?postId=123"
	private Date created_at;
	
    private boolean read;  // DB 칼럼 is_read 와 매핑될 프로퍼티

    public boolean isRead() {
        return read;
    }
    public void setRead(boolean read) {
        this.read = read;
    }
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
		
}
