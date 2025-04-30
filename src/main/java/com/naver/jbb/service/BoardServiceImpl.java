package com.naver.jbb.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.jbb.dao.BoardDao;
import com.naver.jbb.dao.CommentDao;
import com.naver.jbb.domain.BoardDraftDto;
import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.SearchCondition;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDao boardDao;
	@Autowired
	private CommentDao commentDao;
	
	//게시글 목록
	@Override
	public List<BoardDto> getList() throws Exception {
		return boardDao.selectAll();
	}
	
	//중분류에 해당하는 게시글 목록
	@Override
	public List<BoardDto> getPostsByCategory(Integer subCategory) throws Exception{
	    return boardDao.getPostsByCategory(subCategory);
	}
		
	//중분류에 해당하는 게시물 개수
	@Override
	public int Subcount(int subCategory) throws Exception{
		return boardDao.Subcount(subCategory);
	}
	
	//전체 게시물 갯수
	@Override
	public int getCount() throws Exception {
		return boardDao.count();
	}
	
	//게시글 상세보기
	@Override
	public BoardDto read(Integer bno) throws Exception {
		return boardDao.select(bno);
	}
	@Override
	public void increaseViewCnt(Integer bno) throws Exception{
		boardDao.increaseViewCnt(bno);
	}
	
	//페이징
	@Override
	public List<BoardDto> getPage(Map map) throws Exception {
		return boardDao.selectPage(map);
	}
	
	//게시물 등록
	@Override
	public int write(BoardDto boardDto) throws Exception {
		return boardDao.insert(boardDto);
	}
	
	//게시물 수정
	@Override
	public int modify(BoardDto boardDto) throws Exception {
		return boardDao.update(boardDto);
	}
	
	//게시물 삭제
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int remove(Integer bno, String writer) throws Exception {		
		int rowCnt = commentDao.deleteAll(bno);
        rowCnt = boardDao.delete(bno, writer);
		
		return rowCnt;
	}
	
	//게시물 검색
	@Override
	public List<BoardDto> getSearchResultPage(SearchCondition sc) throws Exception {
		return boardDao.searchSelectPage(sc);
	}
	
	//검색된 게시물 개수
	@Override
	public int getSearchResultCnt(SearchCondition sc) throws Exception {
		return boardDao.searchResultCnt(sc);
	}
	
	//최신글 5개
	@Override
	public List<BoardDto> getLatestPosts() throws Exception{
		return boardDao.getLatestPosts();
	}
	//인기글 5개
	@Override
	public List<BoardDto> getPopularPosts() throws Exception{
		return boardDao.getPopularPosts();
	}
	
	//내가 쓴 글 목록
	@Override
	public List<BoardDto> myboardlist(String writer) throws Exception{
		return boardDao.myboardlist(writer);
	}
	
	//좋아요 한 글 목록
	@Override
	public List<BoardDto> mylikeslist(String user_id) throws Exception{
		return boardDao.mylikeslist(user_id);
	}
	
	//내가 쓴 댓글
	@Override
	public List<BoardDto> mycommentlist(String commenter) throws Exception{
		return boardDao.mycommentlist(commenter);
	}
	
	//게시물 임시저장하기 & 업데이트
	@Override
	public void saveDraft(BoardDraftDto boardDraftDto) throws Exception{
		if(boardDraftDto.getDraft_id()==null) {
			boardDao.insertDraft(boardDraftDto);
		} else {
			boardDao.updateDraft(boardDraftDto);
		}
	}	
	//작성자별 최신 Draft 한 건 조회
	@Override
	public BoardDraftDto getDraft(String writer) throws Exception{
		return boardDao.selectDraftByWriter(writer);
	}
	//Draft 삭제 (최종 게시 후)
	@Override
	public int removeDraft(Integer draft_id) throws Exception{
		return boardDao.deleteDraft(draft_id);
	}
}
