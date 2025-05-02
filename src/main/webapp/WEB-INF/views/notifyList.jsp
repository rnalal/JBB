<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="data_path" value="${pageContext.request.contextPath }/resources" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBB</title>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<style>
	body {
		text-align:center;
		display: flex; /* 플렉스 컨테이너로 설정 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    margin: 0; /* 기본 여백 제거 */
	    text-align: center; /* 내부 텍스트 가운데 정렬 */
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
	
	.notify-item {
        border-bottom: 2px solid #ddd;
        padding: 20px;
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .notify-title {
        font-size: 30px;
        flex: 1;
        font-weight:bold;
    }

    .toggle-icon {
        font-size: 30px;
        color: #FF8C00;
        cursor: pointer;
    }

    .notify-content {
    	font-size:30px;
        display: none;
        padding: 20px;
        background-color: #f9f9f9;
        margin-top: 5px;
        padding-bottom: 40px; /* 날짜 아래 여백 추가 */
    }
    
    .nofity_list {
    	margin-top:50px;
    }
    
    .search-container {
      width: 100%;
      height: 110px;
      margin-top : 10px;
      margin-bottom: 30px;
      border: none;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    
    .search-form {
      height: 45px;
      display: flex;
    }
    
    .search-option {
      width: 200px;
      height: 55px;
      outline: none;
      margin-right: 5px;
      border: 1px solid #ccc;
      color: gray;
      font-size: 25px;
    }

    .search-option > option {
      text-align: center;
    }

    .search-input {
      color: gray;
      background-color: #E0E0E0;
      border: none;
      height: 100%;
      width: 600px;
      font-size: 25px;
      padding: 5px 7px;
    }
    
    .search-input placeholder {
    	color:#D3D3D3;
    }

    .search-button {
      border:none;
      width: 20%;
      height: 55px;
      background-color: #FF8C00;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 30px;
    }  
    
    .no-result{
    	font-size: 30px;
		margin-top:150px;
		width: 932px;
		text-align:center;
		color:#FF8C00;
		font-weight:bold;
    }
    
    .notify-container {
	    width: 900px; 
	    overflow-wrap: break-word;
	    word-wrap: break-word;
	}
	
	.notify-content pre {
	    white-space: pre-wrap;
	    word-break: break-word;
	    overflow-wrap: break-word;
	}
	
	.notify-actions {
	    float: right;
	    margin-right: 10px;
	}
	
	.modifyBtn, .removeBtn {
	    background: none;
	    border: none;
	    cursor: pointer;
	    font-size: 16px;
	    margin-left: 5px;
	}
	
	.notify-actions a{
		text-decoration:none;
	}
	
	.notify-date {
		font-size:25px;
		float:right;
	}
</style>
</head>
<body>
<div class="notify-container">
	<div class="jbb-title">
		<div class="title-left">
		    <button type="button" class="backbtn" onclick="history.back()"><</button>
		    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
		    <div class="title-right">
			    <%@ include file="/WEB-INF/views/common_notification.jsp" %>
			 </div>
	    </div>
		<h2>공지사항</h2>
		<%@ include file="/WEB-INF/views/timeout.jsp" %>
	</div>
	<!-- 검색 기능 -->
	<div class="search-container">
	<form action="<c:url value='/notify/list'/>" class="search-form" method="get">
	     <select class="search-option" name="option">
	         <option value="A" ${sc.option == 'A' ? "selected" : ""}>제목+내용</option>
	         <option value="T" ${sc.option == 'T' ? "selected" : ""}>제목</option>
	     </select>
	     <input type="text" name="keyword" class="search-input" value="${sc.keyword}" placeholder="검색어를 입력해주세요">
	     <input type="submit" class="search-button" value="검색">
	 </form>
	</div>
	<c:choose>
        <c:when test="${empty list}">
            <p class="no-result">해당하는 공지사항이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="notifyDto" items="${list}">
                <div class="notify-item" data-id="${notifyDto.nno}">
                    <span class="notify-title">${notifyDto.ntitle}</span>
                    <span class="toggle-icon">▼</span>
                </div>
                <div class="notify-content">
	                <pre>${notifyDto.ncontent}</pre>
	                <span class="notify-date">
						<fmt:formatDate value="${notifyDto.n_date}" pattern="yyyy.MM.dd" />
					</span>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
<!-- 화살표 토글 -->	
<script>
	$(document).ready(function () {
	    $(".toggle-icon").click(function () {
	        var content = $(this).closest(".notify-item").next(".notify-content");
	        var icon = $(this); // 현재 클릭한 아이콘 저장

	        // 토글 애니메이션 실행 후 아이콘 변경
	        content.slideToggle(300, function () {
	            if (content.is(":visible")) {
	                icon.text("▲"); // 내용이 보일 때 위 화살표
	            } else {
	                icon.text("▼"); // 내용이 숨겨질 때 아래 화살표
	            }
	        });
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