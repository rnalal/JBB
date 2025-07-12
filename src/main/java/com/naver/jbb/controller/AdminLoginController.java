package com.naver.jbb.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.jbb.domain.UserDto;
import com.naver.jbb.service.AdminService;
import com.naver.jbb.service.UserService;

@Controller
public class AdminLoginController {
	
	@Autowired
	AdminService adminService;
	@Autowired
	UserService userService;
	
	//관리자 로그인
	@GetMapping("/adminlogin")
	public String login() {
		return "admin_login";
	}
	@PostMapping("/adminlogin")
	public String login(String id, String pwd, String toURL,
			HttpServletRequest request, HttpServletResponse response, RedirectAttributes rattr) throws Exception {
		
		if(!loginCheck(id, pwd)) {
			rattr.addFlashAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
			return "redirect:/adminlogin";
		}

		HttpSession session = request.getSession();
		session.setAttribute("id", id);	
		
		//세션 타이머 추가
		session.setAttribute("loginTime", System.currentTimeMillis());
		
		//로그인 횟수 증가
		userService.incrementLoginCount(id);
		return "redirect:/admin/userlist";
	}
	private boolean loginCheck(String id, String pwd) {
		UserDto userdto = null;
		
		try {
			userdto = userService.login(id);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return userdto!=null && userdto.getPwd().equals(pwd);
	}
	
	//관리자 로그아웃
	@GetMapping("/adminlogout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "admin_login";
	}
}
