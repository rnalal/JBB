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
	
	.user-table-container{
		flex-grow:1; /*남은 공간을 전부 차지*/
		margin-right:20px;
		margin-top:20px;
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
		padding: 40px;
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
	
	.boardcount a{
		color: #5a5a5a;
	}
	
	.userid a{
		color:#5a5a5a;
	}
	
	button.writebtn {
	    position: fixed; /* 고정 위치 */
	    bottom: 10vh; 
	    right: 2vw; /* 화면 오른쪽에서 2% 위치 */
	    background-color: #FF8C00; /* 버튼 배경색 */
	    color: white;
	    padding: 10px 20px; /* 내부 여백 */
	    border: none;
	    border-radius: 50px; /* 둥근 모서리 */
	    font-size: 40px;
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	    cursor: pointer;
	    z-index: 1000; /* 항상 위에 표시 */
	    transition: all 0.3s ease-in-out; /* 크기/위치 전환 효과 */
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
		<form action="<c:url value="/admin/userlist"/>" class="search-form" method="get">
			<select name="option" class="search-option">
          		<option class="option" value="N" ${ph.sc.option=='N' ? "selected" : ""}>아이디</option>
          		<option class="option" value="E" ${ph.sc.option=='E' ? "selected" : ""}>이메일</option>
		    </select>
		    <input type="text" name="keyword" class="search-input" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
        	<input type="submit" class="search-button" value="검색">
		</form>
	</div>
</div>
<div class="content-container">	
	<%@ include file="side-menu.jsp" %>
	<!-- 사용자 목록 테이블 -->
	<div class="user-table-container">
		<span class="alluser">전체 사용자 ( ${totalUsers} )</span>
		<table class="user-table">
			<thead>
			    <tr>
			        <th>ID</th>
			        <th>이메일</th>
			        <th>가입일</th>
			        <th>작성한 글</th>
			     </tr>
			 </thead>
			 <tbody>
			 <c:forEach var="userDto" items="${userDto}">
			      <tr>
			          <td class="userid">
			          	<a href="${path}/admin/userdetail?id=${userDto.id}&page=${param.page}&pageSize=${param.pageSize}">
						    ${userDto.id}
						</a>
			          </td>
			          <td>${userDto.email}</td>
			          <td><fmt:formatDate pattern = "yyyy. MM. dd" value="${userDto.reg_date}"/></td>
				      <td class="boardcount">
						<a href="${path}/admin/userboard?writer=${userDto.id}">
					        ${userDto.boardCount}
					    </a>
					  </td>
			       </tr>
			  </c:forEach>
			  </tbody>
		</table>
		<div class="paging">
			<c:if test="${totalUsers==null || totalUsers==0}">
			      <div class="nolist"> 사용자가 없습니다. </div>
			</c:if>
			<c:if test="${totalUsers!=null && totalUsers!=0}">
				<c:if test="${ph.showPrev}">
				    <a class="page" href="<c:url value="/admin/userlist${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
				</c:if>
				<c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
				    <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/admin/userlist${ph.sc.getQueryString(i)}"/>">${i}</a>
				</c:forEach>
				<c:if test="${ph.showNext}">
				    <a class="page" href="<c:url value="/admin/userlist${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
				</c:if>
			</c:if>
		</div>
	</div>
</div>
<button type="button" class="writebtn "id="writeBtn" onclick="location.href='<c:url value="/admin/userinsert"/>'">+</button>
<script>
	let msg = "${msg}";
	if(msg=="DEL_OK") alert("사용자가 삭제되었습니다.");
	if(msg=="INSERT_OK") alert("사용자가 등록되었습니다.");
</script>
</body>
</html>