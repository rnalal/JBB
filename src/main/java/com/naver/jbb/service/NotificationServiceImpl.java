package com.naver.jbb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import com.naver.jbb.dao.NotificationDao;
import com.naver.jbb.domain.Notification;

@Service
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	private SimpMessagingTemplate template;
	@Autowired
	private NotificationDao notificationDao;
	
	// userId(글 작성자)에게 1:1 알림 보내기
	@Override
	public void sendToUser(String userId, Notification noti) {
		//구독 경로: /user/{userId}/queue/notifications
		template.convertAndSendToUser(
				userId,
				"/queue/notifications",
				noti
		);
	}
	
	@Override 
	public List<Notification> getAll(String userId) throws Exception {
		return notificationDao.selectAll(userId);
	}
	@Override
	public int getUnreadCount(String userId) throws Exception {
		return notificationDao.countUnread(userId);
	}
	@Override
	public int markAllRead(String userId) throws Exception{
		return notificationDao.markAllRead(userId);
	}
}
