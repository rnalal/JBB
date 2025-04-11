package com.naver.jbb.dao;

import com.naver.jbb.domain.LikesDto;

public interface LikesDao {

	//좋아요 추가
	int addLike(LikesDto likesDto) throws Exception;
	
	//좋아요 삭제
	int removeLike(LikesDto likesDto) throws Exception;
	
	//좋아요 개수
	int getLikeCount(int board_bno) throws Exception;
	
	//사용자가 해당 게시물에 좋아요 눌렀는지 확인
	int isLikeByUser(LikesDto likesDto) throws Exception;
	
}
