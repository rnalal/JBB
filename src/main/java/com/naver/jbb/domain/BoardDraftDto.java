package com.naver.jbb.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class BoardDraftDto {
	private Integer draft_id;
	private String writer;
	private String title;
	private String content;
	private String img1;
	private String img2;
	private String img3;
	private Integer b_bc_code;
	private Integer kip_cnt;
	private Date up_date;
	
	public BoardDraftDto() {}	
	public BoardDraftDto(String writer, String title, String content) {
		this.writer = writer;
		this.title = title;
		this.content = content;
	}
	
	//이미지 업로드
	private MultipartFile file1;
	private MultipartFile file2;
	private MultipartFile file3;	
		
	public MultipartFile getFile1() { return file1; }
	public void setFile1(MultipartFile file1) { this.file1 = file1; }
	public MultipartFile getFile2() { return file2; }
	public void setFile2(MultipartFile file2) { this.file2 = file2; }
	public MultipartFile getFile3() { return file3; }
	public void setFile3(MultipartFile file3) { this.file3 = file3; }
		
	public Integer getDraft_id() {
		return draft_id;
	}
	public void setDraft_id(Integer draft_id) {
		this.draft_id = draft_id;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImg1() {
		return img1;
	}
	public void setImg1(String img1) {
		this.img1 = img1;
	}
	public String getImg2() {
		return img2;
	}
	public void setImg2(String img2) {
		this.img2 = img2;
	}
	public String getImg3() {
		return img3;
	}
	public void setImg3(String img3) {
		this.img3 = img3;
	}
	public Integer getB_bc_code() {
		return b_bc_code;
	}
	public void setB_bc_code(Integer b_bc_code) {
		this.b_bc_code = b_bc_code;
	}
	public Integer getKip_cnt() {
		return kip_cnt;
	}
	public void setKip_cnt(Integer kip_cnt) {
		this.kip_cnt = kip_cnt;
	}
	public Date getUp_date() {
		return up_date;
	}
	public void setUp_date(Date up_date) {
		this.up_date = up_date;
	}
	
}
