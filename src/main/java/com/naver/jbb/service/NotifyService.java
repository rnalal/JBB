package com.naver.jbb.service;

import java.util.List;

import com.naver.jbb.domain.NotifyDto;
import com.naver.jbb.domain.SearchCondition;

public interface NotifyService {

	//공지사항 목록 
	List<NotifyDto> selectAll(SearchCondition sc) throws Exception;
	
	//공지사항 개수
	int notifyCnt(SearchCondition sc) throws Exception;
	
	//공지사항 상세보기
	NotifyDto detail(Integer nno) throws Exception;
	
	//공지사항 등록
	int write(NotifyDto notifyDto) throws Exception;
		
	//공지사항 수정
	int modify(NotifyDto notifyDto) throws Exception;
		
	//공지사항 삭제 
	int delete(Integer nno) throws Exception;
}
