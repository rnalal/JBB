package com.naver.jbb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.naver.jbb.dao.NotifyDao;
import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.NotifyDto;
import com.naver.jbb.domain.SearchCondition;

@Service
public class NotifyServiceImpl implements NotifyService{
	
	@Autowired
	private NotifyDao notifyDao;
	
	//공지사항 목록 
	@Override
	public List<NotifyDto> selectAll(SearchCondition sc) throws Exception{
		return notifyDao.selectAll(sc);
	}
	
	//공지사항 개수
	@Override
	public int notifyCnt(SearchCondition sc) throws Exception{
		return notifyDao.notifyCnt(sc);
	}
	
	//공지사항 상세보기
	@Override
	public NotifyDto detail(Integer nno) throws Exception{
		return notifyDao.detail(nno);
	}
	
	//공지사항 등록
	@Override
	public int write(NotifyDto notifyDto) throws Exception{
		return notifyDao.insert(notifyDto);
	}
		
	//공지사항 수정
	@Override
	public int modify(NotifyDto notifyDto) throws Exception{
		return notifyDao.update(notifyDto);
	}
		 
	//공지사항 삭제 
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int delete(Integer nno) throws Exception{
		return notifyDao.delete(nno);
	}

}
