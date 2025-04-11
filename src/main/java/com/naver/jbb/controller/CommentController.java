package com.naver.jbb.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.naver.jbb.domain.CommentDto;
import com.naver.jbb.service.CommentService;

@RestController
public class CommentController {

	@Autowired
	CommentService service;
	
	//댓글 수정 
	@PatchMapping("/comments/{cno}") // {cno}는 URL 경로의 일부
	public ResponseEntity<String> modify(@PathVariable Integer cno, 
			@RequestBody CommentDto dto, HttpSession session){
		String commenter = (String)session.getAttribute("id");
		dto.setCommenter(commenter);
		dto.setCno(cno);
		
		try {
			if(service.modify(dto)!=1)
				throw new Exception("Write failed");
			
			return new ResponseEntity<>("MOD_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("MODO_ERR", HttpStatus.BAD_REQUEST);
		}	
	}
	
	//댓글 등록
	@PostMapping("/comments")
	public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session){
		String commenter = (String)session.getAttribute("id");
		dto.setCommenter(commenter);
		dto.setBno(bno);
		
		try {
			if(service.write(dto)!=1)
				throw new Exception("Write failed");
			
			return new ResponseEntity<>("WRT_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("WRT_ERR", HttpStatus.BAD_REQUEST); 
		}
	}
	
	//지정된 댓글 삭제
	@DeleteMapping("/comments/{cno}") 
	public ResponseEntity<String> remove(@PathVariable Integer cno, 
			Integer bno, HttpSession session) {
		String commenter = (String)session.getAttribute("id");
		
		try {
            int rowCnt = service.remove(cno, bno, commenter);

            if(rowCnt!=1)
                throw new Exception("Delete Failed");

            return new ResponseEntity<>("DEL_OK", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR", HttpStatus.BAD_REQUEST);
        }
	}
	
	//댓글 목록
	@GetMapping("/comments") 
	public ResponseEntity<List<CommentDto>> list(Integer bno){
		List<CommentDto> list = null;
		
		try {
			list = service.getList(bno);
			return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK); 
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); 
		}

	}
}
