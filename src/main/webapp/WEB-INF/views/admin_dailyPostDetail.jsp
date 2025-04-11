<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 최상위경로 -->
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="data_path" value="${pageContext.request.contextPath }/resources" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBB</title>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<style>
	html, body {
	    height: 100%;
	    margin: 0;
	    padding: 0;
	}
	
	.content-container {
		display:flex;
		align-items:flex-start;
		gap:20px;
		align-items: stretch; /* 높이를 동일하게 맞춤 */
		min-height: 100vh;
	}
	
	.menu-container {
		flex-shrink: 0; /* 사이드메뉴 크기 고정 */
		width: 250px; /* admin_menu.jsp의 사이드메뉴 너비와 맞춤 */
	}
	
	.top-bar{
		display:flex;
		align-items: center; /* 세로 중앙 정렬 */
		justify-content: space-between; /*왼쪽 타이틀과 오른쪽 검색창을 양 끝으로 배치*/
		background-color:#5a5a5a;
		height:70px;
		margin-top: 0;
		padding: 0 20px;
	}
	
	.main-title{
		font-size:30px;
		font-weight:bold;
		color:#FF8C00;
		margin-right:10px;
		margin-left:10px;
	}
	
	.side-title{
		font-size:20px;
		font-weight:bold;
		color:#ddd;
	}
	
	.container{
		flex-grow:1; /*남은 공간을 전부 차지*/
		margin-right:20px;
		margin-top:20px;
	} 
	
	.search-container {
      width: 500px;
      height: 40px;
      border: none;
      display: flex;
      align-items: center;
      margin-right:20px;
    }
    
    .search-form {
      height: 45px;
      display: flex;
    }
    
    .search-option {
      width: 200px;
      height: 40px;
      outline: none;
      margin-right: 5px;
      border: 1px solid #ccc;
      color: gray;
      font-size: 20px;
    }
    
    .search-option > option {
      text-align: center;
    }

    .search-input {
      color: gray;
      background-color: #E0E0E0;
      border: none;
      height: 40px;
      width: 250px;
      font-size: 20px;
      padding: 0 10px;
    }

	.search-input placeholder {
    	color:#D3D3D3;
    }

    .search-button {
      border:none;
      width: 40%;
      height: 40px;
      background-color: #FF8C00; 
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 20px;
    }  
	
	.paging {
	    display: flex; /* 플렉스 레이아웃 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 수직 중앙 정렬 */
	    margin-top: 20px;
	}
		
	.paging a {
		text-decoration: none; /* 밑줄 제거 */
	    font-size: 20px; /* 글자 크기 */
	    color: #333; /* 글자 색상 */
	    padding: 5px 10px; /* 숫자 버튼 안쪽 여백 */
	    border-radius: 4px; /* 둥근 테두리 */
	    transition: background-color 0.3s ease; /* 호버 효과 */
	}
	
	.paging a:hover {
	    background-color: #f0f0f0; /* 호버 시 배경색 */
	}
	 
	.paging a.paging-active {
	    background-color: #f0f0f0; /* 현재 페이지 배경색 */
	    color: #333; /* 글자 색 */
	    border-radius: 20%; /* 동그라미 */
	    padding: 5px 10px; /* 숫자 버튼 안쪽 여백 */
	    border: 1px solid #ccc; /* 테두리 */
	    font-weight: bold; /* 강조 */
	}
	
	.paging a.paging-active:hover {
	    background-color: #e0e0e0; /* 호버 시 더 짙은 회색 */
	}  
	
	.user-table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
	}
	
	.user-table th, .user-table td {
	    border: 1px solid #ddd;
	    text-align: center;
	    font-size:20px;
	    color: #5a5a5a;
	    border-left: none;  /* 세로 줄 제거 */
  		border-right: none; 
	}
	
	.user-table th {
		padding: 20px;
	    background-color: #E2E2E2;
	    color: gray;
	    border-bottom: 2px solid #5a5a5a;
	    font-weight:bold;
	}
	
	.user-table td{
		padding: 20px;
	} 
	
	.nolist{
		font-size: 30px;
		margin-top:150px;
		width: 932px;
		text-align:center;
		color:#5a5a5a;
		font-weight:bold;
	}  
	
	.alluser{
		font-size: 25px;
		font-weight: bold;
		color: #5a5a5a;
	}
	
	.nolist{
		font-size: 30px;
		margin-top:150px;
		width: 932px;
		text-align:center;
		color:#5a5a5a;
		font-weight:bold;
	} 
	
	td a{
		color: #5a5a5a;
	} 
	
	.tit{
		color:#FF8C00;
	} 
	
	.img{
		width:100px;
		height:100px;
		border-radius: 8px;
	}
</style>
</head>
<body>
<div class="top-bar">
	<div class="title">
		<span class="main-title">JBB</span>
		<span class="side-title">for admin only</span>
	</div>
	<div class="search-container">
		<form action="<c:url value="/admin/dailyPostDetail"/>" class="search-form" method="get">
			<input type="hidden" name="reg_date" value="${reg_date}">
			<select name="option" class="search-option">
          		<option class="option" value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목</option>
		    </select>
		    <input type="text" name="keyword" class="search-input" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
        	<input type="submit" class="search-button" value="검색">
		</form>
	</div>
</div>
<div class="content-container">	
	<%@ include file="side-menu.jsp" %>
	<div class="container">		
		   <span class="alluser"><span class="tit">${reg_date}</span> 에 작성된 게시글</span>
		   <table class="user-table">
			   <thead>
			       <tr>
			           <th>번호</th>
			           <th>카테고리</th>
			           <th>썸네일</th>
                	   <th>제목</th>
                	   <th>작성자</th>
                	   <th>조회수</th>
			       </tr>
			   </thead>
			   <tbody>
			       <c:forEach var="post" items="${list}">
			           <tr>
		                    <td>
		                    	<a href="${path}/admin/admin_boarddetail?bno=${post.bno}">
		                    		${post.bno}
		                    	</a>	
		                    </td>
		                    <td>${post.bc_name}</td>
		                    <td>
		                    	<c:choose>
									<c:when test="${not empty post.img1}">
										<img src="${data_path}/upload/${post.img1}" alt="대표 이미지" class="img">
									</c:when>
									<c:otherwise>
										<img src="${data_path}/img/default_img.png" alt="기본 이미지" class="img">
									</c:otherwise>
								</c:choose>
		                    </td>
		                    <td>
		                    	<c:choose>
									<c:when test="${fn:length(post.title) > 15}">
										${fn:substring(post.title, 0, 15)}...
									</c:when>	
									<c:otherwise>
										${post.title}
									</c:otherwise>
								</c:choose>
		                    </td>
		                    <td>${post.writer}</td>
		                    <td>${post.view_cnt}</td>
		                </tr>
			       </c:forEach>
			   </tbody>
			</table>      
			<div class="paging">
				<c:if test="${totalCnt==null || totalCnt==0}">
				      <div class="nolist"> 게시물이 없습니다. </div>
				</c:if>
				<c:if test="${totalCnt!=null && totalCnt!=0}">
					<c:if test="${ph.showPrev}">
					    <a class="page" href="<c:url value="/admin/dailyPostDetail${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
					</c:if>
					<c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
					    <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/admin/dailyPostDetail${ph.sc.getQueryString(i)}"/>">${i}</a>
					</c:forEach>
					<c:if test="${ph.showNext}">
					    <a class="page" href="<c:url value="/admin/dailyPostDetail${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
					</c:if>
				</c:if>
			</div>
	</div>
</div>	 
</body>
</html>