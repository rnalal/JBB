package com.naver.jbb;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.service.BoardService;

@Controller
public class HomeController {
	
	@Autowired
	BoardService boardService;	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session, Model m) {
		String writer = (String)session.getAttribute("id");
		try {
			List<BoardDto> latestPosts = boardService.getLatestPosts();
			List<BoardDto> popularPosts = boardService.getPopularPosts();
			m.addAttribute("latestPosts", latestPosts);
			m.addAttribute("popularPosts",popularPosts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}
	
}
