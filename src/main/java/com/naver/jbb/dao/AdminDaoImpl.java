package com.naver.jbb.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.CommentDto;
import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.NotifyDto;
import com.naver.jbb.domain.QnaDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.domain.UserActivityDto;
import com.naver.jbb.domain.UserDto;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Autowired
	private SqlSession session;
	private static String namespace = "com.naver.jbb.dao.AdminMapper.";

	// 사용자 목록 조회
	@Override
	public List<UserDto> getUserListPaging(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "getUserListPaging", sc);
	}

	@Override
	public int getTotalUserCount(SearchCondition sc) throws Exception {
		return session.selectOne(namespace + "getTotalUserCount", sc);
	}

	// 사용자목록-작성한 게시글 목록
	@Override
	public List<BoardDto> userboard(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "userboard", sc);
	}

	@Override
	public int getuserboardCount(SearchCondition sc) throws Exception {
		return session.selectOne(namespace + "getuserboardCount", sc);
	}

	// 사용자 상세조회
	@Override
	public UserDto userdetail(String id) throws Exception {
		return session.selectOne(namespace + "userdetail", id);
	}

	// 사용자 삭제
	@Override
	public int userdelete(String id) throws Exception {
		return session.delete(namespace + "userdelete", id);
	}

	// 사용자 추가
	@Override
	public int userinsert(UserDto userDto) throws Exception {
		return session.insert(namespace + "userinsert", userDto);
	}

	@Override
	public int checkuserId(String id) throws Exception {
		return session.selectOne(namespace + "checkuserId", id);
	}

	// 문의 목록 조회
	@Override
	public List<QnaDto> qnalist(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "qnalist", sc);
	}

	@Override
	public int qnaCount(SearchCondition sc) throws Exception {
		return session.selectOne(namespace + "qnaCount", sc);
	}

	// 문의 상세보기
	@Override
	public QnaDto qnadetail(Integer qno) throws Exception {
		return session.selectOne(namespace + "qnadetail", qno);
	}

	// 답변 작성
	@Override
	public int insertAnswer(QnaDto qnaDto) throws Exception {
		return session.insert(namespace + "insertAnswer", qnaDto);
	}

	@Override
	public int is_answered_update(Integer parent_id) throws Exception {
		return session.update(namespace + "is_answered_update", parent_id);
	}

	// 문의 삭제
	@Override
	public int qnadelete(Integer qno) throws Exception {
		return session.delete(namespace + "qnadelete", qno);
	}

	// 답변 삭제
	@Override
	public int answerdelete(Integer parent_id) throws Exception {
		return session.delete(namespace + "answerdelete", parent_id);
	}

	@Override
	public int answerdelete_update(Integer qno) throws Exception {
		return session.update(namespace + "answerdelete_update", qno);
	}

	// 공지사항 목록
	@Override
	public List<NotifyDto> admin_notify_list(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "admin-notify-list", sc);
	}

	// FAQ 작성
	@Override
	public int faqInsert(FaqDto faqDto) throws Exception {
		return session.insert(namespace + "faqInsert", faqDto);
	}

	// FAQ 목록
	@Override
	public List<FaqDto> faqAll(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "faqAll", sc);
	}

	// FAQ 개수
	@Override
	public int faqCnt(SearchCondition sc) throws Exception {
		return session.selectOne(namespace + "faqCnt", sc);
	}

	// FAQ 상세보기
	@Override
	public FaqDto faqdetail(Integer fno) throws Exception {
		return session.selectOne(namespace + "faqdetail", fno);
	}

	// FAQ 수정
	@Override
	public int faqUpdate(FaqDto faqDto) throws Exception {
		return session.update(namespace + "faqUpdate", faqDto);
	}

	// FAQ 삭제
	@Override
	public int faqDelete(Integer fno) throws Exception {
		return session.delete(namespace + "faqdelete", fno);
	}

	// 게시판 목록
	@Override
	public List<BoardDto> admin_boardlist(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "admin_boardlist", sc);
	}

	@Override
	public int boardCnt(SearchCondition sc) throws Exception {
		return session.selectOne(namespace + "boardCnt", sc);
	}

	// 게시물 상세보기
	@Override
	public BoardDto admin_boarddetail(Integer bno) throws Exception {
		return session.selectOne(namespace + "admin_boarddetail", bno);
	}

	// 게시물 삭제
	@Override
	public int admin_boardremove(Integer bno) throws Exception {
		return session.delete(namespace + "admin_boardremove", bno);
	}

	// 인사이트 분석
	// 일,주,월별 신규 가입자 수
	@Override
	public List<Map<String, Object>> getDailyNewUsers() throws Exception {
		return session.selectList(namespace + "getDailyNewUsers");
	}

	@Override
	public List<Map<String, Object>> getWeeklyNewUsers() throws Exception {
		return session.selectList(namespace + "getWeeklyNewUsers");
	}

	@Override
	public List<Map<String, Object>> getMonthlyNewUsers() throws Exception {
		return session.selectList(namespace + "getMonthlyNewUsers");
	}
	// 사용자 활동 빈도
	@Override
	public List<UserActivityDto> getAllUserActivity(SearchCondition sc) throws Exception {
		return session.selectList(namespace + "getAllUserActivity", sc);
	}
	@Override
	public int userActivityCnt(SearchCondition sc) throws Exception {
		return session.selectOne(namespace + "userActivityCnt", sc);
	}	
	//카테고리 게시글 수
	@Override
	public List<Map<String, Object>> BoardCategoryCnt() throws Exception{
		return session.selectList(namespace+"BoardCategoryCnt");
	}
	@Override
	public List<BoardDto> BoardCategoryDetail(SearchCondition sc) throws Exception{
		return session.selectList(namespace+"BoardCategoryDetail", sc);
	}
	@Override
	public int BoardCategoryDetailCnt(SearchCondition sc) throws Exception{
		return session.selectOne(namespace+"BoardCategoryDetailCnt", sc);
	}
	//일별 게시글 작성 수
	@Override
	public List<BoardDto> getDailyPostCount(SearchCondition sc) throws Exception{
		return session.selectList(namespace+"getDailyPostCount", sc);
	}
	@Override
	public int getDailyPostCountTotal(SearchCondition sc) throws Exception{
		return session.selectOne(namespace+"getDailyPostCountTotal",sc);
	}
	//일자별 상세페이지
	@Override
	public List<BoardDto> getPostsByDate(SearchCondition sc) throws Exception{
		return session.selectList(namespace+"getPostsByDate", sc);
	}
	@Override
	public int countPostsByDate(SearchCondition sc) throws Exception{
		return session.selectOne(namespace+"countPostsByDate", sc);
	}
}
