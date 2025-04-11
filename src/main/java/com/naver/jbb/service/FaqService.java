package com.naver.jbb.service;

import java.util.List;

import com.naver.jbb.domain.FaqDto;
import com.naver.jbb.domain.SearchCondition;

public interface FaqService {

	List<FaqDto> user_faqlist(SearchCondition sc) throws Exception;
}
