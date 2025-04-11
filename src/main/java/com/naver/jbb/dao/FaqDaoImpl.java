package com.naver.jbb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.SearchCondition;

@Repository
public class FaqDaoImpl implements FaqDao{
	@Autowired
	private SqlSession session;
	private static String namespace="com.naver.jbb.dao.FaqMapper.";
	
	@Override
	public List<FaqDto> user_faqlist(SearchCondition sc) throws Exception{
		return session.selectList(namespace+"user-faqlist", sc);
	}
}
