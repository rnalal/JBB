package com.naver.jbb.service;

import java.util.List;

import com.naver.jbb.domain.Notification;

public interface NotificationService {

	void sendToUser(String userId, Notification noti) throws Exception;
	List<Notification> getAll(String userId) throws Exception;
	int getUnreadCount(String userId) throws Exception;
	int markAllRead(String userId) throws Exception;
}
