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
  <style>
    body {
      	display: flex; /* 플렉스 컨테이너로 설정 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	    flex-direction: column; /* 컨텐츠를 세로로 배치 */
	    margin: 0; /* 기본 여백 제거 */
	    height: 100vh; /* 화면 전체 높이 사용 */
	    justify-content: flex-start;
    }
    
    .jbb-title {
   		display: flex;
	    align-items: center;
	    justify-content: space-between; /* 양쪽 정렬 */
	    width: 900px; /* 900px 안에서 정렬 */
	    margin: 0 auto; /* 가운데 정렬 */
	    position: relative;
	    padding-top:30px;
   	}
   	
   	.jbb-title h2 {
	    font-size: 40px;
	    text-align: center;
	    color: black;
	    flex: 1;
	    position: absolute;
	    left: 50%;
	    transform: translateX(-50%); /* 완벽한 가운데 정렬 */
	}
	
	.title-left {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	}
	
	/* home버튼 */
    .home-icon {
		width: 50px; 
		height: 50px; 
		cursor: pointer;
		filter: invert(39%) sepia(99%) saturate(1000%) hue-rotate(-10deg); /* #FF8C00 색상 적용 */
	}
	
	.backbtn {
		font-size: 40px; /* 화살표 크기 */
		color: #FF8C00; /* 화살표 색상 */
		background: none; /* 배경 제거 */
		border: none; /* 테두리 제거 */
		cursor: pointer;
		padding: 0;
		width:100px;
	}
    
    .container {
      	width: 900px; /* 전체 크기를 900px로 고정 */
	    display: flex;
	    flex-direction: column;
	    padding: 16px;
	    box-sizing: border-box;
	    background-color: #ffffff;
	    margin-top:20px;
    }
    
    .notification-list {
      list-style: none;
      margin: 0; padding: 0;
    }
    
    .notification-item {
      display: flex;
      align-items: center;
      padding: 12px 16px;
      border-bottom: 1px solid #eee;
      transition: background 0.2s;
    }
    
    .notification-item.unread {
      background: #eee;
      padding:50px;
      border-bottom:1px solid #5a5a5a;
    }
    
    .notification-item.read {
      background: #eee;
      color: #999;
    }
    
    .notification-icon {
      font-size: 40px;
      margin-right: 12px;
    }
    
    .notification-content {
      flex: 1;
    }
    
    .notification-message {
      display: block;
      margin: 0 0 4px;
      font-size: 30px;
      text-decoration: none;
      color: inherit;
    }
    
    .notification-timestamp {
      font-size: 25px;
      color: #5a5a5a;
    }
    
    .empty {
      padding: 50px;
      text-align: center;
      color: #5a5a5a;
      font-size: 30px;
    }
  </style>
</head>
<body>
<div class="body">
<div class="jbb-title">
	<div class="title-left">
	    <button type="button" class="backbtn" onclick="history.back()"><</button>
	    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
	    <div class="title-right">
		    <%@ include file="/WEB-INF/views/common_notification.jsp" %>
		 </div>
    </div>
    <h2>내 알림</h2>
    <%@ include file="/WEB-INF/views/timeout.jsp" %>
</div>
  <div class="container">
    <c:if test="${empty notifications}">
      <div class="empty">받은 알림이 없습니다.</div>
    </c:if>
    <ul class="notification-list">
      <c:forEach var="n" items="${notifications}">
        <li class="notification-item ${n.read ? 'read' : 'unread'}">
          <span class="notification-icon">
            <c:choose>
              <c:when test="${n.type=='COMMENT'}">&#x1F4AC;</c:when>
              <c:when test="${n.type=='LIKE'}">❤️</c:when>
              <c:otherwise>🔔</c:otherwise>
            </c:choose>
          </span>
          <div class="notification-content">
            <a href="${ctx}${n.url}" class="notification-message">
              ${n.message}
            </a>
            <div class="notification-timestamp">
              <fmt:formatDate value="${n.created_at}" pattern="yyyy.MM.dd HH:mm:ss"/>
            </div>
          </div>
        </li>
      </c:forEach>
    </ul>
  </div>
 </div>
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