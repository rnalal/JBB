package com.naver.jbb.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.LikesDto;

@Repository
public class LikesDaoImpl implements LikesDao{

	@Autowired
	private SqlSession session;
	private static String namespace="com.naver.jbb.dao.LikesMapper.";

	//좋아요 추가
	@Override
	public int addLike(LikesDto likesDto) throws Exception{
		return session.insert(namespace+"addLike", likesDto);
	}
	
	//좋아요 삭제
	@Override
	public int removeLike(LikesDto likesDto) throws Exception {
		return session.delete(namespace+"removeLike", likesDto);
	}
	
	//좋아요 개수
	@Override
	public int getLikeCount(int board_bno) throws Exception {
		return session.selectOne(namespace+"getLikeCount",board_bno);
	}
	
	//사용자가 해당 게시물에 좋아요 눌렀는지 확인
	@Override
	public int isLikeByUser(LikesDto likesDto) throws Exception {
		return session.selectOne(namespace+"isLikeByUser", likesDto);
	}
	
}
