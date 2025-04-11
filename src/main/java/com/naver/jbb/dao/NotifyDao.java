package com.naver.jbb.dao;

import java.util.List;

import com.naver.jbb.domain.NotifyDto;
import com.naver.jbb.domain.SearchCondition;

public interface NotifyDao {

	//공지사항 목록 
	List<NotifyDto> selectAll(SearchCondition sc) throws Exception;
	
	//공지사항 개수
	int notifyCnt(SearchCondition sc) throws Exception;
	
	//공지사항 상세보기
	NotifyDto detail(Integer nno) throws Exception;
	
	//공지사항 등록
	int insert(NotifyDto notifyDto) throws Exception;
	
	//공지사항 수정
	int update(NotifyDto notifyDto) throws Exception;
	
	//공지사항 삭제 
	int delete(Integer nno) throws Exception;
}
