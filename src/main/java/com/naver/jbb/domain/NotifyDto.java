package com.naver.jbb.domain;

import java.util.Date;

public class NotifyDto {
	private Integer nno;
	private String ntitle;
	private String ncontent;
	private Date n_date;
	
	public NotifyDto() {}
	public NotifyDto(Integer nno, String ntitle, String ncontent) {
		this.nno = nno;
		this.ntitle = ntitle;
		this.ncontent = ncontent;
	}
	public Integer getNno() {
		return nno;
	}
	public void setNno(Integer nno) {
		this.nno = nno;
	}
	public String getNtitle() {
		return ntitle;
	}
	public void setNtitle(String ntitle) {
		this.ntitle = ntitle;
	}
	public String getNcontent() {
		return ncontent;
	}
	public void setNcontent(String ncontent) {
		this.ncontent = ncontent;
	}
	public Date getN_date() {
		return n_date;
	}
	public void setN_date(Date n_date) {
		this.n_date = n_date;
	}
	
	@Override
	public String toString() {
		return "NotifyDto [nno=" + nno + ", ntitle=" + ntitle + ", ncontent=" + ncontent + ", n_date=" + n_date + "]";
	}
	
}
