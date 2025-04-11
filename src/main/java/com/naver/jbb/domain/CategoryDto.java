package com.naver.jbb.domain;

import java.util.Objects;

public class CategoryDto {
	private Integer bc_code;
	private String bc_name;
	private Integer bc_code_ref_mn;
	
	public CategoryDto() {}
	public CategoryDto(Integer bc_code, String bc_name, Integer bc_code_ref_mn) {
		this.bc_code = bc_code;
		this.bc_name = bc_name;
		this.bc_code_ref_mn = bc_code_ref_mn;
	}
	public Integer getBc_code() {
		return bc_code;
	}
	public void setBc_code(Integer bc_code) {
		this.bc_code = bc_code;
	}
	public String getBc_name() {
		return bc_name;
	}
	public void setBc_name(String bc_name) {
		this.bc_name = bc_name;
	}
	public Integer getBc_code_ref_mn() {
		return bc_code_ref_mn;
	}
	public void setBc_code_ref_mn(Integer bc_code_ref_mn) {
		this.bc_code_ref_mn = bc_code_ref_mn;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(bc_code, bc_code_ref_mn, bc_name);
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CategoryDto other = (CategoryDto) obj;
		return Objects.equals(bc_code, other.bc_code) && Objects.equals(bc_code_ref_mn, other.bc_code_ref_mn)
				&& Objects.equals(bc_name, other.bc_name);
	}
	
	@Override
	public String toString() {
		return "boardcatgyDto [bc_code=" + bc_code + ", bc_name=" + bc_name + ", bc_code_ref_mn=" + bc_code_ref_mn
				+ "]";
	}

}
