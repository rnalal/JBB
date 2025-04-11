package com.naver.jbb.service;

import java.util.List;
import java.util.Map;

import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.CategoryDto;
import com.naver.jbb.domain.SearchCondition;

public interface BoardService {

	//게시글 목록
	List<BoardDto> getList() throws Exception;
	
	//중분류에 해당하는 게시글 목록
	List<BoardDto> getPostsByCategory(Integer subCategory) throws Exception;	
	//중분류에 해당하는 게시물 개수
	int Subcount(int subCategory) throws Exception;

	//전체 게시물 갯수
	int getCount() throws Exception;
	
	//게시글 상세보기
	BoardDto read(Integer bno) throws Exception;
	
	//페이징
	List<BoardDto> getPage(Map map) throws Exception;
	
	//게시물 등록
	int write(BoardDto boardDto) throws Exception;
	
	//게시물 수정
	int modify(BoardDto boardDto) throws Exception;
	
	//게시물 삭제
	int remove(Integer bno, String writer) throws Exception;
	
	//게시물 검색
	List<BoardDto> getSearchResultPage(SearchCondition sc) throws Exception;
	
	//검새된 게시물 개수
	int getSearchResultCnt(SearchCondition sc) throws Exception;
	
	//최신글 5개
	List<BoardDto> getLatestPosts() throws Exception;
	//인기글 5개
	List<BoardDto> getPopularPosts() throws Exception;
	
	//내가 쓴 글 목록
	List<BoardDto> myboardlist(String writer) throws Exception;
	
	//좋아요 한 글 목록
	List<BoardDto> mylikeslist(String user_id) throws Exception;
	
	//내가 쓴 댓글
	List<BoardDto> mycommentlist(String commenter) throws Exception;
}
