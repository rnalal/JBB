package com.naver.jbb.domain;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Objects;

import org.springframework.web.multipart.MultipartFile;

public class BoardDto {
	private Integer bno;
	private String title;
	private String content;
	private String img1;
	private String img2;
	private String img3;
	private int b_bc_code; //카테고리 코드번호
	private int view_cnt;
	private int comment_cnt; //댓글개수
	private Date reg_date;
	private int kip_cnt; //저장개수
	private String writer;
	private LocalDateTime up_date; //수정한날짜
	private String bc_name;
	private String comment;
	private Integer post_count;

	public Integer getPost_count() {
		return post_count;
	}
	public void setPost_count(Integer post_count) {
		this.post_count = post_count;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getBc_name() {
		return bc_name;
	}
	public void setBc_name(String bc_name) {
		this.bc_name = bc_name;
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
	
	public BoardDto() {}	
	public BoardDto(String title, String content, String writer) {
		this.title = title;
		this.content = content;
		this.writer = writer;
	}
	
	public LocalDateTime getUp_date() {
        return up_date;
    }
	public void setUp_date(LocalDateTime up_date) {
        this.up_date = up_date;
    }
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
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
	public int getB_bc_code() {
		return b_bc_code;
	}
	public void setB_bc_code(int b_bc_code) {
		this.b_bc_code = b_bc_code;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public int getComment_cnt() {
		return comment_cnt;
	}
	public void setComment_cnt(int comment_cnt) {
		this.comment_cnt = comment_cnt;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getKip_cnt() {
		return kip_cnt;
	}
	public void setKip_cnt(int kip_cnt) {
		this.kip_cnt = kip_cnt;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(b_bc_code, bno, content, img1, img2, img3, title, writer);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BoardDto other = (BoardDto) obj;
		return b_bc_code == other.b_bc_code && Objects.equals(bno, other.bno) && Objects.equals(content, other.content)
				&& Objects.equals(img1, other.img1) && Objects.equals(img2, other.img2)
				&& Objects.equals(img3, other.img3) && Objects.equals(title, other.title)
				&& Objects.equals(writer, other.writer);
	}
	@Override
	public String toString() {
		return "BoardDto [bno=" + bno + ", title=" + title + ", content=" + content + ", img1=" + img1 + ", img2="
				+ img2 + ", img3=" + img3 + ", b_bc_code=" + b_bc_code + ", view_cnt=" + view_cnt + ", comment_cnt="
				+ comment_cnt + ", reg_date=" + reg_date + ", kip_cnt=" + kip_cnt
				+ ", writer=" + writer + ", up_date=" + up_date + "]";
	}	

}
