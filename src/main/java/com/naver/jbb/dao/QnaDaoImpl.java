package com.naver.jbb.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.QnaDto;

@Repository
public class QnaDaoImpl implements QnaDao{
	
	@Autowired
	private SqlSession session;
	private static String namespace="com.naver.jbb.dao.QnaMapper.";
	
	//질문 목록 조회
	@Override
	public List<QnaDto> getAllQuestions() throws Exception{
		return session.selectList(namespace+"getAllQuestions");				
	}
	
	//내가 쓴 질문 목록
	@Override
	public List<QnaDto> selectUserQnaList(String userId) throws Exception{
		return session.selectList(namespace+"selectUserQnaList", userId);
	}
	
	//질문 상세보기 -> 질문&답변 조회
	@Override
	public QnaDto getQuestionWithAnswer(Integer qno, String userId) throws Exception {
		Map map = new HashMap();
		map.put("qno", qno);
		map.put("userId", userId);
		return session.selectOne(namespace+"getQuestionWithAnswer", map);
	}
	
	//질문 작성
	@Override
	public int insertQuestion(QnaDto qnaDto) throws Exception{
		return session.insert(namespace+"insertQuestion", qnaDto);	
	}
	
	//질문 삭제
	@Override
	public int delete_question(Integer qno) throws Exception{
		return session.delete(namespace+"delete_question", qno);
	}
	
}
