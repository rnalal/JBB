<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 최상위경로 -->
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="data_path" value="${pageContext.request.contextPath }/resources" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBB</title>
</head>
<style>
	body {
		display: flex; /* 플렉스 컨테이너로 설정 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	    flex-direction: column; /* 컨텐츠를 세로로 배치 */
	    margin: 0; /* 기본 여백 제거 */
	    height: 100vh; /* 화면 전체 높이 사용 */
	    text-align: center; /* 내부 텍스트 가운데 정렬 */
	    padding-top: 50px; /* 화면 위에 여백 추가 */
	}
	
	.jbb-title {
	    display: flex;
	    align-items: center;
	    justify-content: space-between; /* 양쪽 정렬 */
	    width: 900px; /* 900px 안에서 정렬 */
	    margin: 0 auto; /* 가운데 정렬 */
	    position: relative;
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
	
	.result-box {
		width: 900px; /* 전체 크기를 900px로 고정 */
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    justify-content: flex-start;
	    min-height: 100vh;
	    padding: 16px;
	    box-sizing: border-box;
	    background-color: #ffffff;
	}
	 
	 .result-box p {
	 	font-size: 40px;
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
    
    a.bottom {
    	display: inline-block; /* 버튼처럼 보이게 설정 */
	    text-decoration: none; /* 밑줄 제거 */
		width: 95%;
	    padding: 30px; /*내부 여백*/
	    margin-top:30px;
	    margin-bottom:30px;
	    font-size: 1rem;
	    color: #fff;
	    background-color: #FF8C00;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 30px;
     }
     
     .id-letter {
     	font-size:40px;
     }
     
     .id-letter a{
     	font-size:55px; 
     	text-decoration: underline;
     }
</style>
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
	<h2>아이디찾기 결과</h2>
</div>

<div class="result-box">
	<c:choose>
		<c:when test="${empty findId}">
		<p class="inquiry">조회결과가 없습니다.</p>
		<a href="<c:url value='/user/join'/>" class="bottom">회원가입</a>
		</c:when>
        <c:otherwise>
          <p class="id-letter">회원님의 아이디는 <a>${findId.id}</a> 입니다.</p>
	      <a href="<c:url value='/user/login'/>" class="bottom">로그인</a>
        </c:otherwise>
	</c:choose>
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