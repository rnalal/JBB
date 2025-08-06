package com.naver.jbb.controller;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.naver.jbb.domain.BoardDraftDto;
import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.CategoryDto;
import com.naver.jbb.domain.PageHandler;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.service.BoardService;
import com.naver.jbb.service.CategoryService;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;	
	@Autowired
	CategoryService categoryService;
	
	//게시물 목록보기 & 페이징
	@GetMapping("/list")
	public String list(SearchCondition sc, Model m, HttpServletRequest request) {
		
		List<CategoryDto> categories = categoryService.getAllCategories();
        m.addAttribute("categories", categories);

		try {			 	        
			int totalCnt = boardService.getSearchResultCnt(sc);
			m.addAttribute("totalCnt", totalCnt);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			List<BoardDto> list = boardService.getSearchResultPage(sc);
			m.addAttribute("list", list);
			m.addAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("totalCnt", 0);
		}
		
		return "boardList";
	}
	
	//중분류에 해당하는 게시글 목록
	@GetMapping("/getPostsByCategory")
	public ResponseEntity<List<BoardDto>> getPostsByCategory(@RequestParam("subCategory") Integer subCategory) {
			
		List<BoardDto> postList = new ArrayList<>(); // 빈 리스트로 초기화
		try {
			postList = boardService.getPostsByCategory(subCategory);

		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(postList); // 예외 발생 시 빈 리스트 반환
		}
	        return ResponseEntity.ok(postList); // 정상 처리 시 리스트 반환
	 }
	
	//게시물 상세보기
	@GetMapping("/read")
	public String read(@RequestParam("bno") Integer bno, 
					   @RequestParam(value="page", required=false) Integer page,
					   @RequestParam(value="pageSize", required=false) Integer pageSize, 
					   Model m, HttpSession session, RedirectAttributes rattr) throws Exception{
		
		//1) 세션에서 'viewedPosts' 꺼내기
		@SuppressWarnings("unchecked")
		Set<Integer> viewed = (Set<Integer>) session.getAttribute("viewedPosts");
		if(viewed == null) {
			 //처음 보는 세션이라면 새 Set 만들어서 세션에 올려두기
			viewed = new HashSet<>();
		}
		//2) 이 글을 한번도 본 적이 없다면
		if(!viewed.contains(bno)) {
			// a) 조회수 증가
			boardService.increaseViewCnt(bno);
			// b) 세션에 본 글로 기록
			viewed.add(bno);
			session.setAttribute("viewedPosts", viewed);
		}
		//3) 실제 상세보기 화면으로 리다이렉트
		rattr.addAttribute("bno", bno);
		rattr.addAttribute("page", page);
        rattr.addAttribute("pageSize", pageSize);
		return "redirect:/board/view";
	}
	@GetMapping("/view")
	public String view(@RequestParam("bno") Integer bno, 
					   @RequestParam(value="page", required=false) Integer page,
					   @RequestParam(value="pageSize", required=false) Integer pageSize, Model m, RedirectAttributes redirect) throws Exception{
		//조회만 수행
		BoardDto boardDto = boardService.read(bno);
		if ( boardDto == null ) {
			//글이 없으면 목록으로 돌려보내며 메시지
			redirect.addFlashAttribute("alertMsg", "삭제되었거나 없는 게시물 입니다.");
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
			return "redirect:/board/list";
		}
		m.addAttribute("page", page);
		m.addAttribute("pageSize", pageSize);
		m.addAttribute("boardDto", boardDto);
		return "boardDetail";
	}
	
	//게시물 등록
	//(대분류만 전달)
	@GetMapping("/write")
	public String write(Model m, HttpSession session) {
        String loginUser = (String)session.getAttribute("id");
        
		List<CategoryDto> categories = categoryService.getAllCategories();
        m.addAttribute("categories", categories);
        
        if(loginUser != null) {
			try {
				BoardDraftDto draft = boardService.getDraft(loginUser);
				if(draft != null) {
	        		m.addAttribute("draft",draft);
	        	}
			} catch (Exception e) {
				e.printStackTrace();
			}     	
        }
		return "boardWrite";
	}
	//(Ajax 요청 - 대분류 선택 시 중분류 리스트 불러오기) 
	@GetMapping("/getSubCategories")
	@ResponseBody
	public List<CategoryDto> getSubCategories(@RequestParam("mainCategory") Integer mainCategory){
	    List<CategoryDto> categories = categoryService.getSubCategories(mainCategory);
	    return categories;
	}
	@PostMapping("/write")
	public String write(BoardDto boardDto, @RequestParam(value = "draft_id", required = false) Integer draftId, Model m, HttpSession session, RedirectAttributes rattr, HttpServletRequest request) {
		String writer = (String)session.getAttribute("id");
		boardDto.setWriter(writer);
		
		//이미지 저장 경로 지정(/resources/upload/)
		String uploadDir = request.getSession().getServletContext().getRealPath("/resources/upload/");
		System.out.println("Upload Directory: " + uploadDir);
		File uploadFolder = new File(uploadDir);
		if(!uploadFolder.exists()) {
			uploadFolder.mkdirs(); //폴더가 없으면 생성
		}
		
		//기존 draft가 있으면 조회해 두기 (기존 이미지명 보관용) ---
	    BoardDraftDto draft = null;
	    if (draftId != null) {
	        try {
				draft = boardService.getDraft(writer);
			} catch (Exception e) {
				e.printStackTrace();
			}
	    }
				
		try {
			//파일 업로드 처리
			MultipartFile[] files = {boardDto.getFile1(), boardDto.getFile2(), boardDto.getFile3()}; 
			String[] fileNames = {null, null, null};
			
			for(int i = 0; i < files.length; i++) {
				if(files[i] != null && !files[i].isEmpty()) {
					String originalFilename = files[i].getOriginalFilename();
					String ext = originalFilename.substring(originalFilename.lastIndexOf("."));  // 확장자 추출
					String storedFileName = UUID.randomUUID().toString() + ext; // 랜덤 UUID 파일명
					files[i].transferTo(new File(uploadDir + storedFileName)); // 파일 저장
					fileNames[i] = storedFileName; // 저장된 파일명 저장
				} else if (draft != null) {
	                // 새 파일이 없으면 draft의 기존 이미지명 사용
	                if (i == 0) fileNames[i] = draft.getImg1();
	                if (i == 1) fileNames[i] = draft.getImg2();
	                if (i == 2) fileNames[i] = draft.getImg3();
	            }
			}
			//DTO에 저장된 파일명 설정
			boardDto.setImg1(fileNames[0]);
			boardDto.setImg2(fileNames[1]);
			boardDto.setImg3(fileNames[2]);
			
			//draft폴더에 있던 이미지파일을 최종 업로드 폴더로 복사
			if(draft != null) {
				String draftDir  = request.getSession().getServletContext().getRealPath("/resources/upload/draft/");
				String uploadDir1 = request.getSession().getServletContext().getRealPath("/resources/upload/");

				for (int i = 0; i < fileNames.length; i++) {
				    String fname = fileNames[i];
				    if (draft != null && fname != null) {
				        File from = new File(draftDir, fname);
				        File to   = new File(uploadDir1, fname);
				        if (from.exists() && !to.exists()) {
				            Files.copy(from.toPath(), to.toPath(), StandardCopyOption.REPLACE_EXISTING);
				        }
				    }
				}
			}
			
			//게시물 저장
			int rowCnt = boardService.write(boardDto);		
			if(rowCnt!=1) throw new Exception("write failed");
			
			// 성공 시 draft 삭제 
	        if (draftId != null) {
	            boardService.removeDraft(draftId);
	        }
			
			rattr.addFlashAttribute("msg", "WRT_OK");
			return "redirect:/board/list";
		} catch (Exception e) {		
			// 실패 시: boardWrite.jsp로 다시, draft 유지
			e.printStackTrace();
			m.addAttribute(boardDto);
			m.addAttribute("msg", "WRT_ERR");
			if (draft != null) {
	            m.addAttribute("draft", draft);
	        }
			return "boardWrite";
		}
	}
	//게시물 임시저장 버튼 클릭 -> AJAX 호출
	@PostMapping("/draft")
	@ResponseBody
	public ResponseEntity<Void> saveDraft(BoardDraftDto boardDraftDto, HttpSession session, HttpServletRequest request){
		String writer = (String)session.getAttribute("id");
		boardDraftDto.setWriter(writer);
		
		//기존 draft 불러오기 (update 시 병합용)
        BoardDraftDto existing = null;
        if (boardDraftDto.getDraft_id() != null) {
            try {
				existing = boardService.getDraft(writer);
			} catch (Exception e) {
				e.printStackTrace();
			}
        }
		
		//임시저장 전용 업로드 폴더
		String draftDir = request.getSession().getServletContext().getRealPath("/resources/upload/draft/");
		File draftFolder = new File(draftDir);
		if(!draftFolder.exists()) draftFolder.mkdirs();
		
		//이미지 파일처리
		MultipartFile[] files = {
				boardDraftDto.getFile1(),
				boardDraftDto.getFile2(),
				boardDraftDto.getFile3()
		};
		String[] stored = new String[3];
		
		for(int i=0;i<files.length;i++) {
			MultipartFile f = files[i];
			if(f != null && !f.isEmpty()) {
				String ext = f.getOriginalFilename().substring(f.getOriginalFilename().lastIndexOf('.'));
				String uuidName = UUID.randomUUID().toString() + ext;
				try {
			          f.transferTo(new File(draftDir, uuidName));
			          stored[i] = uuidName;
			        } catch (Exception e) {
			          e.printStackTrace();
			        }
			      } else if(existing != null) {
			    	  // 새 파일이 없으면 기존 Draft의 값을 유지
		              if (i == 0) stored[0] = existing.getImg1();
		              if (i == 1) stored[1] = existing.getImg2();
		              if (i == 2) stored[2] = existing.getImg3();
		            }
			      }
			    boardDraftDto.setImg1(stored[0]);
			    boardDraftDto.setImg2(stored[1]);
			    boardDraftDto.setImg3(stored[2]);
			    
		try {
			boardService.saveDraft(boardDraftDto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.ok().build();
	}
	//게시 완료 후 Draft 삭제 필요시
	@PostMapping("/draft/delete")
	@ResponseBody
	public ResponseEntity<Void> deleteDraft(@RequestParam int draft_id) {
		try {
			boardService.removeDraft(draft_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ResponseEntity.ok().build();
	}
	
	//게시물 삭제
	@PostMapping("/remove")
	public String remove(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr) {
		String writer = (String)session.getAttribute("id");
		try {
			
			int rowCnt = boardService.remove(bno, writer);
			
			if(rowCnt!=1) 
				throw new Exception("board remove error");
			
			rattr.addAttribute("page", page); // 리다이렉트 URL에 포함
	        rattr.addAttribute("pageSize", pageSize); // 리다이렉트 URL에 포함				
			rattr.addFlashAttribute("msg", "DEL_OK");
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute("msg", "DEL_ERR");
		}		
		return "redirect:/board/list";
	}
	
	//게시물 수정
	@GetMapping("/modify")
	public String modify(@RequestParam("bno") Integer bno, @RequestParam(value="page", required=false) Integer page,
						 @RequestParam(value="pageSize", required=false) Integer pageSize, Model m) {
		try {
			BoardDto boardDto = boardService.read(bno); //bno로 게시물 조회
			m.addAttribute("boardDto", boardDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
			return "boardModify";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/board/list"; // 실패 시 리스트로
		} 
	}
	@PostMapping("/modify")
	public String modify(BoardDto boardDto,
						 @RequestParam(value="img1_hidden", required=false) String img1_hidden,
						 @RequestParam(value="img2_hidden", required=false) String img2_hidden,
						 @RequestParam(value="img3_hidden", required=false) String img3_hidden,
						 Integer page, Integer pageSize, Model m, HttpSession session, 
						 RedirectAttributes rattr, HttpServletRequest request) {
		String writer = (String)session.getAttribute("id");
		boardDto.setWriter(writer);
		
		// 이미지 저장 경로 지정(/resources/upload/)
	    String uploadDir = request.getSession().getServletContext().getRealPath("/resources/upload/");
	    System.out.println("Upload Directory: " + uploadDir);
	    File uploadFolder = new File(uploadDir);
	    if (!uploadFolder.exists()) {
	        uploadFolder.mkdirs(); // 폴더가 없으면 생성
	    }

	    try {
	        // 파일 업로드 처리
	        MultipartFile[] files = {boardDto.getFile1(), boardDto.getFile2(), boardDto.getFile3()};
	        String[] fileNames = {img1_hidden, img2_hidden, img3_hidden}; // 기존 이미지 유지

	        for (int i = 0; i < files.length; i++) {
	            if (files[i] != null && !files[i].isEmpty()) { // 새로운 파일이 업로드된 경우
	                String originalFilename = files[i].getOriginalFilename();
	                String ext = originalFilename.substring(originalFilename.lastIndexOf(".")); // 확장자 추출
	                String storedFileName = UUID.randomUUID().toString() + ext; // 랜덤 UUID 파일명
	                
	                files[i].transferTo(new File(uploadDir + storedFileName)); // 파일 저장
	                fileNames[i] = storedFileName; // 새로운 파일명으로 업데이트
	            } 
	            // 새로운 파일이 없을 경우 기존 이미지 유지 (fileNames[i]는 hidden 필드에서 가져온 값 유지)
	        }

	        // DTO에 저장된 파일명 설정
	        boardDto.setImg1(fileNames[0]);
	        boardDto.setImg2(fileNames[1]);
	        boardDto.setImg3(fileNames[2]);

	        // 게시물 수정
	        if (boardService.modify(boardDto) != 1)
	            throw new Exception("Modify failed.");

	        rattr.addAttribute("page", page);
	        rattr.addAttribute("pageSize", pageSize);
	        rattr.addFlashAttribute("msg", "MOD_OK");
	        return "redirect:/board/list";		
		} catch (Exception e) {
			e.printStackTrace();
			m.addAttribute(boardDto);
			m.addAttribute("page", page);
			m.addAttribute("pageSize", pageSize);
			m.addAttribute("msg", "MOD_ERR");
			return "boardModify";
		}
	}

	//내가 쓴 글 목록
	@GetMapping("/myboardlist")
	public String myboardlist(String writer, Model m, HttpSession session) {
		writer = (String)session.getAttribute("id");
		
		try {
			List<BoardDto> list = boardService.myboardlist(writer);
			m.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "myboardlist";
	}
	
	//좋아요 한 글 목록
	@GetMapping("/mylikeslist")
	public String mylikeslist(String user_id, Model m, HttpSession session) {
		user_id = (String)session.getAttribute("id");
		try {
			List<BoardDto> list = boardService.mylikeslist(user_id);
			m.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mylikeslist";
	}
	
	//내가 쓴 댓글
	@GetMapping("/mycommentlist")
	public String mycommentlist(String commenter, Model m, HttpSession session) {
		commenter = (String)session.getAttribute("id");
		
		try {
			List<BoardDto> list = boardService.mycommentlist(commenter);
			m.addAttribute("list", list);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mycommentlist";
	}
}
