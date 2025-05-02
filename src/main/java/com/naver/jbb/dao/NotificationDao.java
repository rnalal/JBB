package com.naver.jbb.dao;

import java.util.List;

import com.naver.jbb.domain.Notification;

public interface NotificationDao {

	//알림 저장
	int insert(Notification n) throws Exception;
	//사용자별 전체 알림 조회
	List<Notification> selectAll(String recipient) throws Exception;	
	//읽지 않은 개수
	int countUnread(String recipient) throws Exception;
	//모두 읽음 처리
	int markAllRead(String recipient) throws Exception;
}
