package com.naver.jbb.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.BoardDraftDto;
import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.SearchCondition;

@Repository
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSession session;
	private static String namespace="com.naver.jbb.dao.BoardMapper.";
	
	//게시글 목록
	@Override
	public List<BoardDto> selectAll() throws Exception {
		return session.selectList(namespace+"selectAll");
	}
	
	//중분류에 해당하는 게시글 목록
	@Override
	public List<BoardDto> getPostsByCategory(Integer subCategory) throws Exception {
		return session.selectList(namespace+"getPostsByCategory",subCategory);
	}
		
	//중분류에 해당하는 게시물 개수
	@Override
	public int Subcount(int subCategory) throws Exception {
		return session.selectOne(namespace+"Subcount");
	} 

	//전체 게시물 개수
	public int count() throws Exception {
		return session.selectOne(namespace+"count");
	}
	
	//게시글 상세보기
	public BoardDto select(int bno) throws Exception {
		return session.selectOne(namespace+"select", bno);
	}
	
	//페이징
	@Override
	public List<BoardDto> selectPage(Map map) throws Exception {
		return session.selectList(namespace+"selectPage", map);
	}
	
	//게시글 조회수 증가
	@Override
	public int increaseViewCnt(Integer bno) throws Exception {
		return session.update(namespace+"increaseViewCnt", bno);
	}
	
	//게시물 등록
	public int insert(BoardDto boardDto) throws Exception {
		return session.insert(namespace+"insert", boardDto);
	}

	//게시물 수정
	@Override
	public int update(BoardDto boardDto) throws Exception {
		return session.update(namespace+"update", boardDto);
	}
	
	//게시물 삭제
	@Override
	public int delete(Integer bno, String writer) throws Exception {
		Map map = new HashMap();
		map.put("bno", bno);
		map.put("writer", writer);
		return session.delete(namespace+"delete", map);
	}
	
	//전체 게시물 삭제
	@Override
	public int deleteAll() {
		return session.delete(namespace+"deleteAll");
	}
	
	//게시물 검색
	@Override
	public List<BoardDto> searchSelectPage(SearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchSelectPage", sc);
	}
	
	//검색된 게시물 개수
	@Override
	public int searchResultCnt(SearchCondition sc) throws Exception {
		return session.selectOne(namespace+"searchResultCnt", sc);
	}

	//댓글개수
	@Override
	public int updateCommentCnt(Integer bno, int cnt) {
		Map map = new HashMap();
		map.put("cnt", cnt);
		map.put("bno", bno);
		return session.update(namespace+"updateCommentCnt", map); 
	}
	
	//최신글 5개
	@Override
	public List<BoardDto> getLatestPosts() throws Exception{
		return session.selectList(namespace+"getLatestPosts");
	}
	//인기글 5개
	@Override
	public List<BoardDto> getPopularPosts() throws Exception{
		return session.selectList(namespace+"getPopularPosts");
	}
	
	//내가 쓴 글 목록
	@Override
	public List<BoardDto> myboardlist(String writer) throws Exception{
		return session.selectList(namespace+"myboardlist", writer);
	}
	
	//좋아요 한 글 목록
	@Override
	public List<BoardDto> mylikeslist(String user_id) throws Exception{
		return session.selectList(namespace+"mylikeslist", user_id);
	}
	
	//내가 쓴 댓글
	@Override
	public List<BoardDto> mycommentlist(String commenter) throws Exception{
		return session.selectList(namespace+"mycommentlist", commenter);
	}
	
	//게시물 임시저장하기
	@Override
	public int insertDraft(BoardDraftDto boardDraftDto) throws Exception{
		return session.insert(namespace+"insertDraft", boardDraftDto);
	}
	//기존 임시저장 게시물 업데이트
	@Override
	public int updateDraft(BoardDraftDto boardDraftDto) throws Exception{
		return session.update(namespace+"updateDraft", boardDraftDto);
	}
	//작성자별 최신 Draft 한 건 조회
	@Override
	public BoardDraftDto selectDraftByWriter(String writer) throws Exception{
		return session.selectOne(namespace+"selectDraftByWriter", writer);
	}
	//Draft 삭제 (최종 게시 후)
	@Override
	public int deleteDraft(Integer draft_id) throws Exception{
		return session.delete(namespace+"deleteDraft", draft_id);
	}
}
