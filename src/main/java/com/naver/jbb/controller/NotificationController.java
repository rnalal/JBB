package com.naver.jbb.controller;

import java.util.Collections;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.naver.jbb.service.NotificationService;

@Controller
public class NotificationController {

	@Autowired
	private NotificationService notificationService;
	
	//알림 목록 페이지
	@GetMapping("/notifications")
	public String list(Model m, HttpSession session) throws Exception {
		String userId = (String)session.getAttribute("id");
		m.addAttribute("notifications", notificationService.getAll(userId));
		return "notifications";
	}
	
	//읽지 않은 개수(AJAX)
	@ResponseBody
	@GetMapping("/notifications/unreadCount")
	public Map<String, Integer> unreadCount(HttpSession session) throws Exception{
		String userId = (String)session.getAttribute("id");
		return Collections.singletonMap("count", notificationService.getUnreadCount(userId));
	}
	
	//모두 읽음 처리 (AJAX or form POST)
	@ResponseBody
	@PostMapping("/notifications/markAllRead")
	public void markAllRead(HttpSession session) throws Exception {
		String userId = (String)session.getAttribute("id");
		notificationService.markAllRead(userId);
	}
}
