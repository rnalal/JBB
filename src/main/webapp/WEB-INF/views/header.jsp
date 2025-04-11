<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- 최상위경로 -->
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="data_path" value="${pageContext.request.contextPath }/resources" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBB</title>
<link rel="stylesheet" href="${data_path }/css/header.css">
</head>
<body>
  <!-- 헤더 -->
    <div class="header">
        <div id="hamburger" class="hamburger">☰</div>
        <div class="logo">JBB</div>
    </div>

    <!-- 사이드바 -->
    <div class="sidebar" id="sidebar">
        <span id="close-btn" class="close-btn">✖</span>
        <a href="<c:url value='/board/list'/>">게시판</a>
        <a href="<c:url value='/board/list'/>">게시판</a>
        <a href="<c:url value='/board/list'/>">게시판</a>
        <a href="">공지사항</a>
        <a href="">문의</a>
        <c:choose>
            <c:when test="${empty id}">
                <a href="<c:url value='/user/login'/>">로그인</a>
                <a href="<c:url value='/user/join'/>">회원가입</a>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/user/mypage'/>">마이페이지</a>
                <a href="<c:url value='/user/logout'/>">로그아웃</a>
            </c:otherwise>    
        </c:choose>
    </div>
    
    <script>
	    document.addEventListener("DOMContentLoaded", function() {
	        const sidebar = document.getElementById("sidebar");
	        const hamburger = document.getElementById("hamburger");
	        const closeBtn = document.getElementById("close-btn");
	
	        // 햄버거 버튼 클릭 시 사이드바 토글
	        hamburger.addEventListener("click", function() {
	            if (sidebar.classList.contains("active")) {
	                sidebar.classList.remove("active");
	                setTimeout(() => {
	                    sidebar.style.display = "none";
	                }, 300); // 애니메이션 후 숨김
	            } else {
	                sidebar.style.display = "flex";
	                setTimeout(() => {
	                    sidebar.classList.add("active");
	                }, 10); // 약간의 딜레이 추가
	            }
	        });
	
	        // X 버튼 클릭 시 사이드바 닫기
	        closeBtn.addEventListener("click", function() {
	            sidebar.classList.remove("active");
	            setTimeout(() => {
	                sidebar.style.display = "none";
	            }, 300);
	        });
	    });
    </script>
</body>
</html> 

