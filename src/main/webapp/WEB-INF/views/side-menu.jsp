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
	.sidemenu{
		display:flex;
		flex-direction: column;
		width:250px;
		background-color:#ddd;
		padding: 10px; 
		margin-left: 0;
		text-align:center; 
	}
	
	.hr{
		border: 1px solid #5a5a5a;
		width: 100%;
	}

	.sidemenu_name{
		margin-top:30px;
		display:flex;
		flex-direction: column;
		gap: 15px;
	}
	
	.name1{
		font-size:20px;
		font-weight:bold;
		color:#5a5a5a;
	}
	
	.name2{
		font-size:20px;
		color: gray;
	}
	
	.name2 a {
	    text-decoration: none;
	    color: inherit;
	}
	
	.name2.active a {
	    color: #FF8C00;
	    font-weight: bold;
	}
	
	.title-left {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	.home-icon {
		width: 30px; 
		height: 30px; 
		cursor: pointer;
		filter: invert(100%) brightness(100%);
		margin-left:20px;
		margin-top:10px;
	} 
	
	/* timeout.jsp 내부에 있거나 외부 스타일에 추가 */
	.session-wrapper {
		position: static !important;
	    float: none !important;
	    margin: 0 auto !important;
	}
	
	#session-container {
		background-color: #f0f0f0 !important;
		border-radius: 10px !important;
		padding: 8px 12px !important;
		font-size: 14px !important;
		color: #333 !important;
		display: flex !important;
		align-items: center !important;
		gap: 10px !important;
	}
	
	#extend-session-btn {
		background-color: #FF8C00 !important;
		color: white !important;
		border: none !important;
		padding: 5px 10px !important;
		border-radius: 5px !important;
		cursor: pointer !important;
		display: none;
	}	
</style>
</head>
<body>
<div class="sidemenu">
    <%@ include file="/WEB-INF/views/timeout.jsp" %>
	<div class="title-left">
		<img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
	</div>
	<div class="sidemenu_name">
		<span class="name1">회원관리</span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/userlist">사용자</a></span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/qnalist">문의내역</a></span>
		<hr class="hr">
		<span class="name1">콘텐츠관리</span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/admin_boardlist">게시판</a></span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/notifylist">공지사항</a></span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/admin_faqlist">FAQ</a></span>
		<hr class="hr">
		<span class="name1">인사이트 분석</span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/user-stats">일,주,월별 가입자수</a></span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/user-activity">사용자 활동빈도</a></span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/user-board-category">게시판 사용량 분석</a></span>
		<span class="name2" onclick="setActive(this)"><a href="${path}/admin/dailyPostStats">일별 게시글 작성 수</a></span>
		<hr class="hr">
		<span class="name2"><a href="${path}/adminlogout">로그아웃</a></span>
	</div>
</div>
	<script>
		$(document).ready(function () {
	        let currentPath = window.location.pathname; // 현재 페이지의 URL 경로
	
	        $(".name2 a").each(function () {
	            let menuPath = $(this).attr("href"); // 각 메뉴의 href 값
	
	            if (currentPath.includes(menuPath)) { // 현재 페이지가 해당 메뉴 경로를 포함하면
	                $(this).parent().addClass("active"); // 부모 요소에 active 클래스 추가
	            }
	        });
	
	        $(".name2").click(function () {
	            $(".name2").removeClass("active"); // 모든 항목에서 active 제거
	            $(this).addClass("active"); // 클릭한 항목에 active 추가
	        });
	    });
	</script>	
	<!-- 홈으로 이동 -->
	<script>
	    document.addEventListener("DOMContentLoaded", function () {
	        const homeIcon = document.getElementById("home-icon");
	        
	        // 집 아이콘 클릭 시 index.jsp로 이동
	        homeIcon.addEventListener("click", function () {
	            window.location.href = "<c:url value='/' />";
	        });
	    });
	</script>
</body>
</html>