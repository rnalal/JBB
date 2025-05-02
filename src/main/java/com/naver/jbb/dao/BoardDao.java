package com.naver.jbb.dao;

import java.util.List;
import java.util.Map;

import com.naver.jbb.domain.BoardDraftDto;
import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.CategoryDto;
import com.naver.jbb.domain.SearchCondition;

public interface BoardDao {
	
	//게시글 목록
	List<BoardDto> selectAll() throws Exception;
	
	//중분류에 해당하는 게시글 목록
	List<BoardDto> getPostsByCategory(Integer subCategory) throws Exception;	
	//중분류에 해당하는 게시물 개수
	int Subcount(int subCategory) throws Exception;
	
	//전체 게시물 개수
	int count() throws Exception;
	
	//게시글 상세보기
	BoardDto select(int bno) throws Exception;
	
	//페이징
	List<BoardDto> selectPage(Map map) throws Exception;
	
	//게시글 조회수 증가
	int increaseViewCnt(Integer bno) throws Exception;
	
	//게시물 등록
	int insert(BoardDto boardDto) throws Exception;
	
	//게시물 수정
	int update(BoardDto boardDto) throws Exception;
	
	//게시물 삭제
	int delete(Integer bno, String writer) throws Exception;
	
	//전체 게시물 삭제
	int deleteAll();
	
	//게시물 검색
	List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception;
		
	//검색된 게시물 개수
	int searchResultCnt(SearchCondition sc) throws Exception;

	//댓글개수
	int updateCommentCnt(Integer bno, int cnt);
	
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
	
	//게시물 임시저장하기
	int insertDraft(BoardDraftDto boardDraftDto) throws Exception;
	//기존 임시저장 게시물 업데이트
	int updateDraft(BoardDraftDto boardDraftDto) throws Exception;
	//작성자별 최신 Draft 한 건 조회
	BoardDraftDto selectDraftByWriter(String writer) throws Exception;
	//Draft 삭제 (최종 게시 후)
	int deleteDraft(Integer draft_id) throws Exception;
	
	//글쓴이 가져오기
	String findWriterByBno(Integer bno) throws Exception;
}
