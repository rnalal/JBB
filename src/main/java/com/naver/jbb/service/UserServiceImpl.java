package com.naver.jbb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jbb.dao.UserDao;
import com.naver.jbb.domain.BoardDto;
import com.naver.jbb.domain.SearchCondition;
import com.naver.jbb.domain.UserDto;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	UserDao userDao;
	
	//회원가입
	@Override
	public int join(UserDto userdto) throws Exception {
		return userDao.insert(userdto);
	}
	
	//회원가입 - 아이디 중복체크
	@Override
	public int checkId(String id) throws Exception {
		int result = 0;
		
		result = userDao.checkId(id);
		return result;
	}
		
	//로그인
	@Override
	public UserDto login(String id) throws Exception {
		return userDao.select(id);
	}
	//로그인횟수증가
	@Override
	public int incrementLoginCount(String id) throws Exception{
		return userDao.incrementLoginCount(id);
	}
	
	//아이디 찾기
	@Override
	public UserDto findUserId(UserDto userdto) throws Exception {
		return userDao.findUserId(userdto);
	}
	
	//마이페이지
	@Override 
	public UserDto mypage(String id) throws Exception {
		return userDao.mypage(id);
	}
	
	//회원정보 수정
	@Override
	public int update(UserDto userdto) throws Exception {
		int result = 0;	
		
		try {
			result = userDao.update(userdto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//탈퇴
	@Override
	public int delete(String id) throws Exception{
		int result = 0;		
		result = userDao.delete(id);
		return result;
	}
	

} 
