package com.naver.jbb.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.jbb.domain.QnaDto;
import com.naver.jbb.service.QnaService;

@Controller
@RequestMapping("/qna")
public class QnaController {
	
	@Autowired
	QnaService qnaService;
	
	/*
	 * //질문 목록 조회
	 * 
	 * @GetMapping("/list") public String list(Model m) throws Exception{
	 * 
	 * List<QnaDto> list = qnaService.getAllQuestion(); m.addAttribute("list",
	 * list);
	 * 
	 * return "qnaList"; }
	 */
	
	//내가 쓴 질문 목록 조회
	@GetMapping("/list")
	public String list(Model m, HttpSession session) throws Exception{
		
		String userId = (String)session.getAttribute("id");
		
		List<QnaDto> list = qnaService.selectUserQnaList(userId);
		m.addAttribute("list", list);
		
		return "qnaList";
	}
	
	//질문 상세보기 -> 질문&답변 조회
	@GetMapping("/detail")
	public String detail(Integer qno, HttpSession session, Model m) {
		
		String userId = (String)session.getAttribute("id");
		
		try {
			QnaDto qnaDetail = qnaService.getQuestionWithAnswer(qno, userId);
			m.addAttribute("qnaDetail",qnaDetail);
			m.addAttribute("loggedInUser", userId); //현재 로그인한 사용자 ID 추가
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "qnaDetail";
	}
	
	//질문 작성
	@GetMapping("/qwrite")
	public String qwrite(QnaDto qnaDto, Model m) {
		m.addAttribute(qnaDto);
		return "questionWrite";
	}
	@PostMapping("/qwrite")
	public String qwrite(QnaDto qnaDto, Model m, HttpSession session, RedirectAttributes rattr) {
		String writer = (String)session.getAttribute("id");
		qnaDto.setWriter(writer);
		int rowCnt;
		try {
			rowCnt = qnaService.insertQuestion(qnaDto);
			m.addAttribute(qnaDto);
			
			if(rowCnt != 1)
				throw new Exception("write failed");
			
				rattr.addFlashAttribute("msg", "QWRT_OK");
				
				return "redirect:/qna/list";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute(qnaDto);
			m.addAttribute("msg", "QWRT_ERR");
			return "questionWrite";
		}		
	}
	
	//질문 삭제
	@PostMapping("/delete")
	public String delete(Integer qno, Model m, HttpSession session, RedirectAttributes rattr) {
		
		try {
			int rowCnt = qnaService.delete_question(qno);
			
			if(rowCnt!=1)
				throw new Exception("qna remove error");
			
			rattr.addFlashAttribute("msg", "DEL_OK");
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "DEL_ERR");
		}
		return "redirect:/qna/list";
	}
}
