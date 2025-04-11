package com.naver.jbb.service;

import java.util.List;

import com.naver.jbb.domain.QnaDto;

public interface QnaService {

	//질문 목록 조회
	List<QnaDto> getAllQuestion() throws Exception;
	
	//내가 쓴 질문 목록
	List<QnaDto> selectUserQnaList(String userId) throws Exception;
	
	//질문 상세보기 -> 질문&답변 조회
	QnaDto getQuestionWithAnswer(Integer qno, String userId) throws Exception;
	
	//질문 작성
	int insertQuestion(QnaDto qnaDto) throws Exception;
	
	//질문 삭제
	int delete_question(Integer qno) throws Exception;
}
