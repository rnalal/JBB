package com.naver.jbb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.domain.UserDto;

@Repository
public class UserDaoImpl implements UserDao {
	
	@Autowired 
	private SqlSession session;
	private static String namespace="com.naver.jbb.dao.UserMapper.";
	
	// 회원가입
	@Override
	public int insert(UserDto userdto) throws Exception {
		return session.insert(namespace+"insert",userdto);	
	}
	
	//회원가입 - 아이디 중복체크
	@Override
	public int checkId(String id) throws Exception {
		return session.selectOne(namespace+"checkId", id);
	}
	
	//로그인
	@Override
	public UserDto select(String id) throws Exception {
		return session.selectOne(namespace+"select", id);
	}
	//로그인횟수증가
	@Override
	public int incrementLoginCount(String id) throws Exception{
		return session.update(namespace+"incrementLoginCount", id);
	}
	
	//아이디 찾기
	@Override
	public UserDto findUserId(UserDto userdto) throws Exception {
		return session.selectOne(namespace+"findUserId", userdto);
	}
	
	//마이페이지
	@Override
	public UserDto mypage(String id) throws Exception {
		return session.selectOne(namespace+"mypage", id);
	}
	
	//회원정보 수정
	@Override
	public int update(UserDto userdto) throws Exception{
		return session.update(namespace+"update",userdto);
	}
	
	//탈퇴
	@Override
	public int delete(String id) throws Exception{
		return session.delete(namespace+"deleteUser", id);
	}

}
