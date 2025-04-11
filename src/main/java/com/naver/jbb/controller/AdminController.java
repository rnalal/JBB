package com.naver.jbb.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.CommentDto;
import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.NotifyDto;
import com.naver.jbb.domain.PageHandler;
import com.naver.jbb.domain.QnaDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.domain.UserActivityDto;
import com.naver.jbb.domain.UserDto;
import com.naver.jbb.service.AdminService;
import com.naver.jbb.service.NotifyService;
import com.naver.jbb.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	@Autowired
	UserService userService;
	@Autowired
	NotifyService notifyService;
	
	//사용자 목록 조회
	@GetMapping("/userlist")
	public String userlist(SearchCondition sc, Model m) {
		
		try {
			int totalUsers = adminService.getTotalUserCount(sc);
			m.addAttribute("totalUsers", totalUsers);
			
			PageHandler pageHandler = new PageHandler(totalUsers, sc);
			
			List<UserDto> userDto = adminService.getUserListPaging(sc);
			m.addAttribute("userDto", userDto);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "userList";
	}
	//사용자가 작성한 게시글 조회
	@GetMapping("/userboard")
	public String userboard(@RequestParam("writer") String writer, Model m, SearchCondition sc) {
		try {
			sc.setWriter(writer); //searchcondition객체에 writer 값 설정
			int totalCount = adminService.getuserboardCount(sc);
			m.addAttribute("totalCount", totalCount);
			
			PageHandler pageHandler = new PageHandler(totalCount, sc);
			
			List<BoardDto> userboard = adminService.userboard(sc);
			m.addAttribute("userboard", userboard);
			m.addAttribute("writer", writer);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "user_board";
	}
	//사용자 상세조회
	@GetMapping("/userdetail")
	public String userdetail(@RequestParam("id") String id, Model m, Integer page, Integer pageSize) {
		
		try {
			UserDto userDto = adminService.userdetail(id);
			m.addAttribute("userDto", userDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "userdetail";
	}
	//사용자 삭제
	@PostMapping("/userdelete")
	public String userdelete(@RequestParam("id") String id, Model m, RedirectAttributes rattr) {
		try {
			int rowCnt = adminService.userdelete(id);
			
			if(rowCnt!=1)
				throw new Exception("user remove error");
			
			rattr.addFlashAttribute("msg", "DEL_OK");
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "DEL_ERR");
		}
		return "redirect:/admin/userlist";
	}
	//사용자 추가
	@GetMapping("/userinsert")
	public String userinsert() {
		return "userinsert";
	}
	@PostMapping("/userinsert")
	public String userinsert(UserDto userDto, BindingResult result, Model m, RedirectAttributes rattr) {
		try {
			int rowCnt = adminService.userinsert(userDto);
			
			if(rowCnt!=1)
				throw new Exception("Insert failed");
			
				rattr.addFlashAttribute("msg", "INSERT_OK");
				
				return "redirect:/admin/userlist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute(userDto);
			m.addAttribute("msg", "INSERT_ERR");
			return "userinsert";
		}	
	}
	@PostMapping("/checkuserId")
	@ResponseBody
	public String checkuserId(@RequestParam("id") String id) throws Exception{
		String result = "N";
		
		int flag = adminService.checkuserId(id);
		
		if(flag == 1) result = "Y";
		
		return result;
	}
	
	//문의 목록 조회
	@GetMapping("/qnalist")
	public String qnalist(SearchCondition sc, Model m) {
	
		try {
			int totalQnas = adminService.qnaCount(sc);
			m.addAttribute("totalQnas", totalQnas);
			
			PageHandler pageHandler = new PageHandler(totalQnas, sc);
			
			List<QnaDto> qnaDto = adminService.qnalist(sc);
			m.addAttribute("qnaDto", qnaDto);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin_qnalist";
	}
	//문의 상세보기
	@GetMapping("/qnadetail")
	public String qnadetail(@RequestParam("qno") Integer qno, Model m, RedirectAttributes rattr) {
		try {
			QnaDto qnaDto = adminService.qnadetail(qno);
			
			m.addAttribute(qnaDto);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin_qnadetail";
	}
	//답변작성
	@PostMapping("/qnaAnswer")
	public String qnaAnswer(QnaDto qnaDto, RedirectAttributes rattr, Model m) {
		try {
			adminService.insertAnswer(qnaDto);
			
			rattr.addFlashAttribute("msg", "ANSWER_OK");
	        
	        return "redirect:/admin/qnadetail?qno=" + qnaDto.getParent_id(); 
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "ANSWER_ERR");
		}
		return "qnalist";
	}
	//문의삭제
	@PostMapping("/qnadelete")
	public String qnadelete(@RequestParam("qno") Integer qno, Model m, RedirectAttributes rattr) {
		try {
			int rowCnt = adminService.qnadelete(qno);
			
			if(rowCnt != 1)
				throw new Exception("qna delete error");
			
			rattr.addFlashAttribute("msg", "QNADEL_OK");
			
			return "redirect:/admin/qnalist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "QNADEL_ERR");
		}
		return "redirect:/admin/qnalist";
	}
	//답변삭제
	@PostMapping("/answerdelete")
	public String answerdelete(@RequestParam("parent_id") Integer parent_id, @RequestParam("qno") Integer qno, 
			Model m, RedirectAttributes rattr) {
		try {
			adminService.answerdelete(parent_id, qno);
			
			rattr.addFlashAttribute("msg", "ANWDEL_OK");
			return "redirect:/admin/qnadetail?qno=" + qno;
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "ANWDEL_ERR");
		}
		return "redirect:/admin/qnadetail?qno="+qno;
	}
	
	//공지사항 목록 
	@GetMapping("/notifylist")
	public String list(@ModelAttribute SearchCondition sc, Model m) throws Exception{
		
		int totalCnt = notifyService.notifyCnt(sc);
		m.addAttribute("totalCnt", totalCnt);
		
		PageHandler pageHandler = new PageHandler(totalCnt, sc);
		
		List<NotifyDto> list = adminService.admin_notify_list(sc);
		m.addAttribute("list",list);
		m.addAttribute("sc", sc);
		m.addAttribute("ph", pageHandler);
		
		return "admin_notifyList";
	}
	//공지사항 등록
	@GetMapping("/notifywrite")
	public String write() {
		return "notifyWrite";
	}
	@PostMapping("/notifywrite")
	public String write(NotifyDto notifyDto, Model m, RedirectAttributes rattr) {
		
		int rowCnt;
		try {
			rowCnt = notifyService.write(notifyDto);
			
			if(rowCnt != 1)
				throw new Exception("write failed");
			
				rattr.addFlashAttribute("msg", "WRT_OK");
				
				return "redirect:/admin/notifylist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute(notifyDto);
			m.addAttribute("msg", "WRT_ERR");
			return "notifyWrite";
		}	
	}
	
	//공지사항 상세보기
	@GetMapping("/notifydetail")
	public String detail(Integer nno, Model m, Integer page, Integer pageSize) {
		
		try {
			NotifyDto notifyDto = notifyService.detail(nno);
			m.addAttribute(notifyDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "notifyDetail";
	}	
	
	//공지사항 수정
	@GetMapping("/notifymodify")
	public String modify(@RequestParam("nno") Integer nno, Model m, Integer page, Integer pageSize) {
		try {
			NotifyDto notifyDto = notifyService.detail(nno);
			m.addAttribute(notifyDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			return "notifyModify";
		}
		return "notifyModify";
	}
	@PostMapping("/notifymodify")
	public String modify(NotifyDto notifyDto, Model m, RedirectAttributes rattr, Integer page, Integer pageSize) {
		
		try {
			if(notifyService.modify(notifyDto) != 1)
				throw new Exception("Modify failed.");
						
			rattr.addFlashAttribute("msg", "MOD_OK");
			rattr.addAttribute("page", page);
			rattr.addAttribute("pageSize", pageSize);
			return "redirect:/admin/notifylist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "MOD_ERR");
			return "notifyModify";
		}

	}
		
	//공지사항 삭제 
	@PostMapping("/notifyremove")
	public String remove(Integer nno, Model m, RedirectAttributes rattr) {
		
		int rowCnt;
		try {
			rowCnt = notifyService.delete(nno);
			
			if(rowCnt!=1)
				throw new Exception("notify remove error");
			
			rattr.addFlashAttribute("msg", "DEL_OK");
			
			return "redirect:/admin/notifylist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "DEL_ERR");
		}
		return "redirect:/admin/notifylist";
	}
	
	//FAQ 작성
	@GetMapping("/faqwrite")
	public String faqwrite() {
		return "faqwrite";
	}
	@PostMapping("/faqwrite")
	public String faqwrite(FaqDto faqDto, Model m, RedirectAttributes rattr) {
		try {
			int rowCnt = adminService.faqInsert(faqDto);
			
			if(rowCnt!=1)
				throw new Exception("write failed");
			
			rattr.addFlashAttribute("msg", "FAQWRT_OK");
			
			return "redirect:/admin/admin_faqlist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "FAQWRT_ERR");
			m.addAttribute(faqDto);
			return "faqwrite";
		}
		
	}
	//FAQ 목록
	@GetMapping("/admin_faqlist")
	public String faqlist(SearchCondition sc, Model m, HttpServletRequest request) {
		try {
			int faqCnt = adminService.faqCnt(sc);
			m.addAttribute("faqCnt", faqCnt);
			
			PageHandler pageHandler = new PageHandler(faqCnt, sc);
			
			List<FaqDto> list = adminService.faqAll(sc);
			m.addAttribute("list", list);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
	return "admin_faqlist";
	}
	//FAQ 상세보기
	@GetMapping("/faqdetail")
	public String faqdetail(Integer fno, Integer page, Integer pageSize, Model m) {
		try {
			FaqDto faqDto = adminService.faqdetail(fno);
			m.addAttribute(faqDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "faqdetail";
	}

	//FAQ 수정
	@GetMapping("/faqmodify")
	public String faqmodify(@RequestParam("fno") Integer fno, Model m, Integer page, Integer pageSize) {

		try {
			FaqDto faqDto = adminService.faqdetail(fno);
			m.addAttribute(faqDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			return "faqmodify";
		}
		return "faqmodify";
	}
	@PostMapping("/faqmodify")
	public String faqmodify(FaqDto faqDto, Integer page, Integer pageSize, Model m, RedirectAttributes rattr) {
		try {
			int rowCnt = adminService.faqUpdate(faqDto);
			
			if(rowCnt!=1)
				throw new Exception("modify error");
			
			rattr.addAttribute("page", page);
			rattr.addAttribute("pageSize", pageSize);
			rattr.addFlashAttribute("msg", "FAQMOD_OK");
			
			return "redirect:/admin/admin_faqlist";
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "FAQMOD_ERR");
		}
		return "faqmodify";
	}
	//FAQ 삭제
	@PostMapping("/faqdelete")
	public String faqdelete(Integer fno, RedirectAttributes rattr, Model m) {
		try {
			
			int rowCnt = adminService.faqDelete(fno);
			
			if(rowCnt!=1)
				throw new Exception("faq delete error");

			rattr.addFlashAttribute("msg", "FAQDEL_OK");
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "FAQDEL_ERR");
		}
		return "redirect:/admin/admin_faqlist";
	}
	
	//게시판 목록
	@GetMapping("/admin_boardlist")
	public String admin_boardlist(SearchCondition sc, Model m) {
		try {
			int totalCnt = adminService.boardCnt(sc);
			m.addAttribute("totalCnt", totalCnt);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			List<BoardDto> list = adminService.admin_boardlist(sc);
			m.addAttribute("list",list);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin_boardlist";
	}
	//게시물 상세보기
	@GetMapping("/admin_boarddetail")
	public String admin_boarddetail(Integer bno, Model m) {
		try {
			BoardDto boardDto = adminService.admin_boarddetail(bno);
			m.addAttribute(boardDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin_boarddetail";
	}
	//게시물 삭제
	@PostMapping("/admin_boardremove")
	public String admin_boardremove(Integer bno, Model m, RedirectAttributes rattr) {
		try {
			int rowCnt = adminService.admin_boardremove(bno);
			
			if(rowCnt!=1)
				throw new Exception("board remove error");
			
			rattr.addFlashAttribute("msg", "AMDEL_OK");
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "AMDEL_ERR");
		}
		return "redirect:/admin/admin_boardlist";
	}
	
	//인사이트 분석
	//일,주,월별 신규 가입자 수
	@GetMapping("/user-stats")
	public String getUSerStats(Model m){

		try {
			List<Map<String, Object>> dailyUsers = adminService.getDailyNewUsers();
			List<Map<String, Object>> weeklyUsers = adminService.getWeeklyNewUsers();
			List<Map<String, Object>> monthlyUsers = adminService.getMonthlyNewUsers();
			
			m.addAttribute("dailyUsers",dailyUsers);
			m.addAttribute("weeklyUsers",weeklyUsers);
			m.addAttribute("monthlyUsers",monthlyUsers);
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return "admin_userStats";
	}
	//사용자 활동 빈도
	@GetMapping("/user-activity")
	public String getAllUserActivity(Model m, SearchCondition sc) {
		try {
			int totalCnt = adminService.userActivityCnt(sc);
			m.addAttribute("totalCnt", totalCnt);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			List<UserActivityDto> userActivities = adminService.getAllUserActivity(sc);
			m.addAttribute("userActivities", userActivities);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "userActivity";
	}
	//카테고리 게시글 수
	@GetMapping("/user-board-category")
	public String userBoardCategory(Model m) {
		try {
			List<Map<String, Object>> categoryPosts  = adminService.BoardCategoryCnt();
			m.addAttribute("categoryPosts", categoryPosts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "userBoardCategory";
	}
	@GetMapping("/board-category-detail")
	public String boardCategoryDetail(SearchCondition sc, BoardDto boardDto, Model m, String bc_name) {
		try {
			int totalCnt = adminService.BoardCategoryDetailCnt(sc);
			m.addAttribute("totalCnt", totalCnt);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			List<BoardDto> boardList = adminService.BoardCategoryDetail(sc);
			m.addAttribute("boardList", boardList);
			m.addAttribute("boardDto", boardDto);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "userBoardCategoryDetail";
	}
	//일별 게시글 작성 수
	@GetMapping("/dailyPostStats")
	public String dailyPostStats(Model m, SearchCondition sc) {
		try {
			int totalCnt = adminService.getDailyPostCountTotal(sc);
			m.addAttribute("totalCnt", totalCnt);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			List<BoardDto> list = adminService.getDailyPostCount(sc);
			m.addAttribute("list", list);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin_dailyPostStats";
	}
	//일자별 상세페이지
	@GetMapping("/dailyPostDetail")
	public String dailyPostDetail(SearchCondition sc, Model m) {
		
		try {			
			int totalCnt = adminService.countPostsByDate(sc);
			m.addAttribute("totalCnt", totalCnt);
			System.out.println(totalCnt);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			List<BoardDto> list = adminService.getPostsByDate(sc);
			m.addAttribute("list", list);
			m.addAttribute("ph", pageHandler);
			m.addAttribute("reg_date", sc.getReg_date());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "admin_dailyPostDetail";
	}
}
