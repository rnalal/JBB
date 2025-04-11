package com.naver.jbb.dao;

import java.util.List;

import com.naver.jbb.domain.CommentDto;

public interface CommentDao {
	
	//댓글 개수
	int count(Integer bno) throws Exception;
	
	//댓글 삭제
	int delete(Integer cno, String commenter) throws Exception;
	
	//특정 게시글에 있는 댓글 모두 삭제
	int deleteAll(Integer bno) throws Exception;
	
	//댓글 등록
	int insert(CommentDto commentDto) throws Exception;
	
	//댓글 목록
	List<CommentDto> selectAll(Integer bno) throws Exception;
	
	//댓글 상세보기
	CommentDto select(Integer cno) throws Exception;
	
	//댓글 수정
	int update(CommentDto dto) throws Exception;
}
