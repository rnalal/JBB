package com.naver.jbb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jbb.dao.QnaDao;
import com.naver.jbb.domain.QnaDto;

@Service
public class QnaServiceImpl implements QnaService{
	
	@Autowired
	private QnaDao qnaDao;
	
	//질문 목록 조회
	@Override
	public List<QnaDto> getAllQuestion() throws Exception{
		return qnaDao.getAllQuestions();
	}
	
	//내가 쓴 질문 목록
	@Override
	public List<QnaDto> selectUserQnaList(String userId) throws Exception{
		return qnaDao.selectUserQnaList(userId);
	}
	
	//질문 상세보기 -> 질문&답변 조회
	@Override
	public QnaDto getQuestionWithAnswer(Integer qno, String userId) throws Exception{
		return qnaDao.getQuestionWithAnswer(qno, userId);
	}
	
	//질문 작성
	@Override
	public int insertQuestion(QnaDto qnaDto) throws Exception{
		return qnaDao.insertQuestion(qnaDto);
	}
	
	//질문 삭제
	@Override
	public int delete_question(Integer qno) throws Exception{
		return qnaDao.delete_question(qno);
	}
}
