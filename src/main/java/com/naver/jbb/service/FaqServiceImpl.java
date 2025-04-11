package com.naver.jbb.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.naver.jbb.dao.FaqDao;
import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.SearchCondition;

@Service
public class FaqServiceImpl implements FaqService{

	@Autowired
	FaqDao faqDao;
	
	@Override
	public List<FaqDto> user_faqlist(SearchCondition sc) throws Exception{
		return faqDao.user_faqlist(sc);
	}
}
