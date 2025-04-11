package com.naver.jbb.dao;

import java.util.List;

import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.domain.UserDto;

public interface UserDao {
	
	//회원가입
	int insert(UserDto userdto) throws Exception;
	
	//회원가입 - 아이디 중복체크
	int checkId(String id) throws Exception;
	
	//로그인
	UserDto select(String id) throws Exception;
	//로그인횟수증가
	int incrementLoginCount(String id) throws Exception;
	
	//아이디 찾기
	UserDto findUserId(UserDto userdto) throws Exception;
	
	//마이페이지	
	UserDto mypage(String id) throws Exception;
	
	//회원정보 수정
	int update(UserDto userdto) throws Exception;
	
	//탈퇴
	int delete(String id) throws Exception;
	
}
