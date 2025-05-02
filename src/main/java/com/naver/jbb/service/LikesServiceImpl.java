package com.naver.jbb.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jbb.dao.BoardDao;
import com.naver.jbb.dao.LikesDao;
import com.naver.jbb.domain.LikesDto;
import com.naver.jbb.domain.Notification;

@Service
public class LikesServiceImpl implements LikesService{
	
	@Autowired
	private LikesDao likesDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private NotificationService notificationService;
	
	//좋아요 추가 & 삭제 (토글)
	@Override
	public boolean toggleLike(LikesDto likesDto) throws Exception{
		if(likesDao.isLikeByUser(likesDto) > 0) {
			// 이미 좋아요 되어 있으면 취소
			likesDao.removeLike(likesDto);
			return false;
		} else {
			//좋아요 추가
			likesDao.addLike(likesDto);
			
			// 1) 글쓴이 조회
			String postOwner = boardDao.findWriterByBno(likesDto.getBoard_bno());
			
			// 2) 알림 생성
			Notification noti = new Notification();
			noti.setType("LIKE");
			noti.setMessage(likesDto.getUser_id()+"님이 좋아요를 눌렀습니다.");
			noti.setUrl("/board/read?bno="+likesDto.getBoard_bno());
			
			// 3) 알림 전송
			notificationService.sendToUser(postOwner, noti);
			return true;
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
