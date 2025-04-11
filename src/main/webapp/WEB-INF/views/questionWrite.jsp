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
</head>
<style>
	body {
		text-align:center;
		display: flex; /* 플렉스 컨테이너로 설정 */
		justify-content: center; /* 가로 중앙 정렬 */
		margin: 0; /* 기본 여백 제거 */
		text-align: center; /* 내부 텍스트 가운데 정렬 */
	}
	
	.container {
	    width: 900px;
	    display: flex; /* 플렉스박스 사용 */
		flex-direction: column; /* 세로 정렬 */
		align-items: flex-start; /* 왼쪽 정렬 (기본값이므로 생략 가능) */
		padding: 16px; /* 내부 여백 */
		margin: 20px auto 16px; /* 위쪽 공백 20px, 좌우 가운데 정렬, 아래쪽 공백 16px */
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
	
	.input-group {
	    display: flex;
	    width: 100%;
	    margin-top: 50px; /* 위쪽 여백 추가 */
	    margin-bottom: 12px; /* 아래쪽 여백 추가 */
	}
		
	textarea {
	    border: 1px solid #ccc;
	    width: 850px;
	    height: 500px;
	    border-radius: 5px;
	    padding-left: 10px;
	    padding-top: 10px;
	    resize: none;
	    font-size:30px;
	    overflow: hidden; /* 스크롤바 숨김 */
	}
	
	textarea::placeholder {
		position: absolute;
	    top: 20px; /* 상단 위치 지정 */
	    left: 20px; /* 왼쪽 위치 지정 */
	    font-size: 25px; /* 폰트 크기 placeholder와 동일하게 설정 */
	    color: #aaa; /* placeholder 색상 */
	}
	
	form {
	    width: 100%;
	    max-width: 900px; /* 폼 크기를 제한 */
	    display: flex;
	    flex-direction: column;
	    gap: 12px;
	 }
	 
	 button {
	  	width: 850px;
	    padding: 30px; /*내부 여백*/
	    margin-top:10px;
	    margin-bottom:10px;
	    font-size: 1rem;
	    color: #fff;
	    background-color: #FF8C00;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 30px;
	}	
</style>
<body>
<div class="container">
    <div class="jbb-title">
        <div class="title-left">
            <button type="button" class="backbtn" onclick="history.back()"><</button>
            <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
        </div>
        <h2>문의 작성</h2>
        <%@ include file="/WEB-INF/views/timeout.jsp" %>
    </div>    
	<form action="<c:url value='/qna/qwrite'/>" method="post" id="form" onsubmit="return validateForm()">
		<input type="hidden" name="qno" value="${qnaDto.qno}">	
		<div class="input-group">
			<textarea name="q_content" id="q_content" rows="1" placeholder="문의사항을 입력하세요"></textarea>
		</div>
		<button type="submit">등록</button>
	</form>
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
<!-- 유효성 검사 -->
<script>
	function validateForm() {
	    let q_content = $("#q_content").val().trim(); // 공백 제거
	
	    if (q_content === "") {
	        alert("질문을 입력해주세요.");
	        return false;
	    }
	    return true;
	}
</script>
<script>
  let msg = "${msg}";
  if(msg=="QWRT_ERR") alert("문의를 등록하지 못했습니다. 다시 시도해 주세요.");
</script>
</body>
</html>