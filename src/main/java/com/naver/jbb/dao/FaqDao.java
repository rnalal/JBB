package com.naver.jbb.dao;

import java.util.List;

import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.SearchCondition;

public interface FaqDao {

	List<FaqDto> user_faqlist(SearchCondition sc) throws Exception;
}
