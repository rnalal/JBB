package com.naver.jbb.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.service.FaqService;

@Controller
@RequestMapping("/faq")
public class FaqController {
	
	@Autowired
	FaqService faqService;
	
	@GetMapping("/user_faqlist")
	public String user_faqlist(SearchCondition sc, Model m) {

		try {
			List<FaqDto> list = faqService.user_faqlist(sc);
			m.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return "user_faqlist";
	}
}
