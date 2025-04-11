package com.naver.jbb.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.jbb.domain.NotifyDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.service.NotifyService;

@Controller
@RequestMapping("/notify")
public class NotifyController {
	
	@Autowired
	NotifyService notifyService;
	
	//공지사항 목록 
	@GetMapping("/list")
	public String list(@ModelAttribute SearchCondition sc, Model m) throws Exception{
		
		List<NotifyDto> list = notifyService.selectAll(sc);
		m.addAttribute("list",list);
		m.addAttribute("sc", sc);
		
		return "notifyList";
	}

}
