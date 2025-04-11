package com.naver.jbb.domain;

import java.util.Date;

public class QnaDto {

	private Integer qno; 
	private Integer parent_id;
	private String writer;
	private String q_content;
	private Date qna_date;
	private Boolean is_answered;
	
	private Integer answer_id;
    private String answer_writer;
	private String a_content;
    private Date answer_date;
    
    private Integer question_id;
    private String question_writer;
    private Date question_date;  
    
	public QnaDto() {}
	public QnaDto(Integer qno, Integer parent_id, String writer, String q_content, String a_content, Date qna_date,
			Boolean is_answered) {
		this.qno = qno;
		this.parent_id = parent_id;
		this.writer = writer;
		this.q_content = q_content;
		this.a_content = a_content;
		this.qna_date = qna_date;
		this.is_answered = is_answered;
	}
	
	public Integer getQuestion_id() {
		return question_id;
	}
	public void setQuestion_id(Integer question_id) {
		this.question_id = question_id;
	}
	public String getQuestion_writer() {
		return question_writer;
	}
	public void setQuestion_writer(String question_writer) {
		this.question_writer = question_writer;
	}
	public Date getQuestion_date() {
		return question_date;
	}
	public void setQuestion_date(Date question_date) {
		this.question_date = question_date;
	}
	public Integer getAnswer_id() {
		return answer_id;
	}
	public void setAnswer_id(Integer answer_id) {
		this.answer_id = answer_id;
	}
	public String getAnswer_writer() {
		return answer_writer;
	}
	public void setAnswer_writer(String answer_writer) {
		this.answer_writer = answer_writer;
	}
	public Date getAnswer_date() {
		return answer_date;
	}
	public void setAnswer_date(Date answer_date) {
		this.answer_date = answer_date;
	}

	public Integer getQno() {
		return qno;
	}
	public void setQno(Integer qno) {
		this.qno = qno;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getQ_content() {
		return q_content;
	}
	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}
	public String getA_content() {
		return a_content;
	}
	public void setA_content(String a_content) {
		this.a_content = a_content;
	}
	public Date getQna_date() {
		return qna_date;
	}
	public void setQna_date(Date qna_date) {
		this.qna_date = qna_date;
	}
	public Boolean getIs_answered() {
		return is_answered;
	}
	public void setIs_answered(Boolean is_answered) {
		this.is_answered = is_answered;
	}
	
	@Override
	public String toString() {
		return "QnaDto [qno=" + qno + ", parent_id=" + parent_id + ", writer=" + writer + ", q_content=" + q_content
				+ ", a_content=" + a_content + ", qna_date=" + qna_date + ", is_answered=" + is_answered + "]";
	}
	
}
