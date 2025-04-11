package com.naver.jbb.domain;

import java.util.Date;

public class FaqDto {
	private Integer fno;
	private String f_question;
	private String f_answer;
	private Date f_date;
	
	public FaqDto() {}
	public FaqDto(String f_question, String f_answer, Date f_date) {
		this.f_question = f_question;
		this.f_answer = f_answer;
		this.f_date = f_date;
	}
	
	public Integer getFno() {
		return fno;
	}
	public void setFno(Integer fno) {
		this.fno = fno;
	}
	public String getF_question() {
		return f_question;
	}
	public void setF_question(String f_question) {
		this.f_question = f_question;
	}
	public String getF_answer() {
		return f_answer;
	}
	public void setF_answer(String f_answer) {
		this.f_answer = f_answer;
	}
	public Date getF_date() {
		return f_date;
	}
	public void setF_date(Date f_date) {
		this.f_date = f_date;
	}
	
	@Override
	public String toString() {
		return "FaqDto [fno=" + fno + ", f_question=" + f_question + ", f_answer=" + f_answer + ", f_date=" + f_date
				+ "]";
	}
	
}
