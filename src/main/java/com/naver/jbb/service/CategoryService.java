package com.naver.jbb.service;

import java.util.List;

import com.naver.jbb.domain.CategoryDto;

public interface CategoryService {

	//카테고리 리스트 불러오기
	List<CategoryDto> getAllCategories();
	
	//중분류 카테고리 리스트 불러오기
	List<CategoryDto> getSubCategories(Integer mainCategory);
}
