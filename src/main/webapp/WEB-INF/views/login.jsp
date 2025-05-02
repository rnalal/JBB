<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="false" %>
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
	
	.backbtn {
		font-size: 40px; /* 화살표 크기 */
	    color: #FF8C00; /* 화살표 색상 */
	    background: none; /* 배경 제거 */
	    border: none; /* 테두리 제거 */
	    cursor: pointer;
	    padding: 0;
	    width:100px;
	}
	
	.login {
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
	
	form {
	    width: 100%;
	    max-width: 900px; /* 폼 크기를 제한 */
	    display: flex;
	    flex-direction: column;
	    gap: 12px;
	}
	
	input[type=text], input[type=password] {
	    width: 100%;
	    padding: 30px;	/*내부 여백*/
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    font-size: 30px; 
	    box-sizing: border-box;
	}
	
	button {
	    width: 100%;
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
	
	a.bottom {
	    font-size: 0.9rem;
	    color: #505050;
	    text-decoration: none;
	}
	
	.letter {
		font-size: 25px;
	}
	
	.letter a{
		font-size: 25px;
	}
	
	.remember {
		font-size:25px;
		display: flex; /* 플렉스 컨테이너로 설정 */
	    align-items: center; /* 체크박스와 텍스트를 세로로 맞춤 */
	    justify-content: flex-start; /* 왼쪽 정렬 */
	    gap: 8px; /* 체크박스와 텍스트 간격 추가 */
	    width: 100%; /* 부모 컨테이너 크기에 맞춤 */
	    margin-bottom: 12px; /* 아래쪽 여백 추가 */
	}
	
	input[type="checkbox"] {
	    width: 25px; /* 너비 */
	    height: 25px; /* 높이 */
	    margin-right: 8px; /* 텍스트와의 간격 */
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
    <h2>로그인</h2>
</div>
<div class="login">
    <form action="<c:url value='/user/login'/>" method="post" onsubmit="return validateForm()">  
            <input type="text" id="id" name="id" value="${cookie.id.value }" placeholder="아이디 입력" autofocus>
            <input type="password" id="pwd" name="pwd" placeholder="패스워드 입력">	
            <label class="remember">
                <input type="checkbox" name="rememberId" value="on" ${empty cookie.id.value ? "":"checked" }> 아이디 기억
            </label> 
            <button type="submit">로그인</button>

        <div class="letter">
            <a href="<c:url value='/user/findIdCheck'/>" class="bottom">아이디찾기</a>  |
            <a href="<c:url value='/user/join'/>" class="bottom">회원가입</a>
        </div>
    </form>
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

<!-- 유효성 검사 -->
<script>
	function validateForm(){
		let id = $("#id").val();
		let pwd = $("#pwd").val();
		
		if(id==""&&pwd==""){
			alert("아이디와 비밀번호를 입력해주세요");
			return false;
		} else if(id==""){
			alert("아이디를 입력해주세요");
			return false;
		} else if(pwd==""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
	}
</script>

</body>
</html>