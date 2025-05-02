package com.naver.jbb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.Notification;

@Repository
public class NotificationDaoImpl implements NotificationDao{

	@Autowired
	private SqlSession session;
	private static String namespace = "com.naver.jbb.dao.NotificationMapper.";
	
	//알림 저장
	@Override
	public int insert(Notification n) throws Exception{
		return session.insert(namespace+"insert", n);
	}
	
	//사용자별 전체 알림 조회
	@Override
	public List<Notification> selectAll(String recipient) throws Exception{
		return session.selectList(namespace+"selectAll", recipient);
	}
	
	//읽지 않은 개수
	@Override
	public int countUnread(String recipient) throws Exception{
		return session.selectOne(namespace+"countUnread", recipient);
	}
	
	//모두 읽음 처리
	@Override
	public int markAllRead(String recipient) throws Exception{
		return session.update(namespace+"markAllRead", recipient);
	}

}
