package com.naver.jbb.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jbb.dao.LikesDao;
import com.naver.jbb.domain.LikesDto;

@Service
public class LikesServiceImpl implements LikesService{
	
	@Autowired
	private LikesDao likesDao;
	
	//좋아요 추가 & 삭제 (토글)
	@Override
	public boolean toggleLike(LikesDto likesDto) throws Exception{
		if(likesDao.isLikeByUser(likesDto) > 0) {
			likesDao.removeLike(likesDto);
			return false; //좋아요 취소
		} else {
			likesDao.addLike(likesDto);
			return true; //좋아요 추가
		}
	}
	
	//좋아요 개수
	@Override
	public int getLikeCount(int board_bno) throws Exception {
		return likesDao.getLikeCount(board_bno);
	}
	
	//좋아요 여부 확인
	@Override
	public boolean isUserLikedPost(int board_bno, HttpSession session) throws Exception{
		String user_id = (String) session.getAttribute("id"); //세션에서 사용자 ID 가져오기
		
		if(user_id==null) {
			return false;
		}
		
		LikesDto likesDto = new LikesDto();
		likesDto.setUser_id(user_id);
		likesDto.setBoard_bno(board_bno);
		
		return likesDao.isLikeByUser(likesDto) > 0;
	}
}
