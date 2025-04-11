package com.naver.jbb.controller;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.jbb.domain.UserDto;
import com.naver.jbb.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;
	
	//회원가입
	@GetMapping("/join")
	public String join() {
		return "registerform";
	}	
	@PostMapping("/join")
	public String join(UserDto userdto, BindingResult result, Model m, RedirectAttributes rattr) throws Exception {
				
			try {
				//DB에 신규회원 정보를 저장
				int rowCnt = userService.join(userdto);
				
				if(rowCnt!=1)
					throw new Exception("Join failed");
				
					rattr.addFlashAttribute("msg", "JOIN_OK");
					
					return "redirect:/";
			} catch (Exception e) {
				e.printStackTrace();
				m.addAttribute(userdto);
				rattr.addFlashAttribute("msg", "JOIN_ERR");
				return "registerform";
			}	
		
	}
	
	//회원가입 - 아이디 중복체크
	@PostMapping("/checkid")
	@ResponseBody
	public String checkId(@RequestParam("id") String id) throws Exception{
		String result = "N";
		
		int flag = userService.checkId(id);
		
		if(flag == 1) result = "Y";

		return result;
	}
	
	// 로그인
	@GetMapping("/login")
	public String login(Model m) {
		return "login";
	}
	@PostMapping("/login")
	public String login(String id, String pwd, String toURL, boolean rememberId, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 1. id와 pwd를 확인
		if(!loginCheck(id, pwd)) {
			// 2-1. 일치하지 않으면 login으로 이동
			PrintWriter out = response.getWriter();
			response.setCharacterEncoding("utf-8");
			response.setContentType("text/html; charset=utf-8");
			out.println("<script> alert('아이디 또는 비밀번호가 틀립니다.');");
			out.println("history.go(-1); </script>"); 
			out.close();
			return "login";
		}
		// 2-2. id와 pwd가 일치하면,
		// 세션 객체 얻어오기
		HttpSession session = request.getSession();
		// 세션 객체에 id를 저장
		session.setAttribute("id", id);
		
		// 세션 유지 시간 및 로그인 시간 저장
		session.setMaxInactiveInterval(1800); //30분
		session.setAttribute("loginTime", System.currentTimeMillis());
		
		//로그인 횟수 증가
		userService.incrementLoginCount(id);
		
		if(rememberId) {
			//1. 쿠키를 생성
			Cookie cookie = new Cookie("id", id);
			// 2. 응답에 저장
			response.addCookie(cookie);
		} else {
			//1. 쿠키를 삭제
			Cookie cookie = new Cookie("id",id);
			cookie.setMaxAge(0); //쿠키삭제
			//2. 응답에 저장
			response.addCookie(cookie);
		}
		// 3. 홈으로 이동		
		return "redirect:/";
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
	
	//로그인연장
	@PostMapping("/extend-session")
	@ResponseBody
	public String extendSession(HttpSession session) {
	    session.setAttribute("loginTime", System.currentTimeMillis());
	    return "ok";
	}
	
	//아이디찾기
	@GetMapping("findIdCheck")
	public String searchId() {
		return "findId";
	}
	@PostMapping("findIdCheck")
	public String searchId(HttpServletRequest request, Model m,UserDto userdto,
			@RequestParam String name, @RequestParam String tel) {
		try {
			userdto.setName(name);
			userdto.setTel(tel);
			UserDto id = userService.findUserId(userdto);

			m.addAttribute("findId", id);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "findId_result";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		//1.세션 종료
		session.invalidate();
		//2.홈으로 이동
		return "redirect:/";
	}
	
	//마이페이지
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model m) throws Exception {
		
		m.addAttribute("userdto", userService.mypage((String)session.getAttribute("id")));
		return "mypage";
	}
	
	//회원정보 수정
	@PostMapping("/update")
	public String update(UserDto userdto, Model m, RedirectAttributes rattr) throws Exception {
		
		int result = userService.update(userdto);
		if(result==1) {
			rattr.addFlashAttribute("msg", "MOD_OK");
			return "redirect:/";
		} 
		rattr.addFlashAttribute("msg", "MOD_ERR");
		return "userudate";
	}
	
	//탈퇴
	@PostMapping("/delete")
	public String delete(HttpSession session, Model m, String id, HttpServletResponse response, RedirectAttributes rattr) throws Exception{
		
		int result = userService.delete((String)session.getAttribute("id"));
		
		if(result==1) {
				session.invalidate();
				
				Cookie cookie = new Cookie("id",id);
				cookie.setMaxAge(0);
				response.addCookie(cookie);
				
				rattr.addFlashAttribute("msg", "DEL_OK");
				return "redirect:/";
			}
		rattr.addFlashAttribute("msg","DEL_ERR");
		return "mypage";
	}
	
}
