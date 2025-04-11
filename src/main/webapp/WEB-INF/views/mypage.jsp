<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	    justify-content: flex-start;
    }
    
    .jbb-title {
   		display: flex;
	    align-items: center;
	    justify-content: space-between; /* 양쪽 정렬 */
	    width: 900px; /* 900px 안에서 정렬 */
	    margin: 0 auto; /* 가운데 정렬 */
	    position: relative;
	    padding-top:20px;
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
	    align-items: center;
	    height: auto;
	    padding: 16px;
	    box-sizing: border-box;
	    background-color: #ffffff;
	}
	
	.container label {
		font-size: 25px;
		width: 150px; /* 모든 라벨의 고정 너비 설정 */
		text-align: left; /* 라벨 텍스트 오른쪽 정렬 */
	    margin: 0; /* 불필요한 여백 제거 */
	    margin-right: 16px; /* 라벨과 입력 필드 간의 간격 */
	}
	
	.input-group {
	    display: flex;
	    align-items: center; /* 라벨과 입력 필드를 세로로 가운데 정렬 */
	    justify-content: flex-start; /* 라벨과 입력 필드를 왼쪽 정렬 */
	    gap: 16px; /* 라벨과 입력 필드 간의 간격 설정 */
	    width: 100%;
	    margin-top: 20px; /* 위쪽 여백 추가 */
	    margin-bottom: 12px; /* 아래쪽 여백 추가 */
	}
	
	.error_msg {
            height: 10px;
            font-size:20px;
            color:red;
            margin-top: -10px;
            text-align: center;
    }
	
	input[type=text], input[type=password] {
	  	flex: 1; /* 입력 필드가 남은 공간을 채우도록 설정 */
	  	width: calc(100% - 150px - 16px); /* 라벨 고정 너비와 간격 제외 */
	    padding: 30px;	/*내부 여백*/
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    font-size: 30px; 
	    box-sizing: border-box;
	}
	
	form {
	    width: 100%;
	    max-width: 900px; /* 폼 크기를 제한 */
	    display: flex;
	    flex-direction: column;
	    gap: 12px;
	 }

	button {
	  	width: 100%;
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
	
	.removeBtn {
		color:#FF8C00;
		background-color:white;
		border:2px solid #FF8C00;
	}
	
	.clearfix {
		display:flex; /*버튼을 가로로 나열*/
		justify-content: space-between; /* 버튼 사이에 간격을 균등하게 */
		gap: 16px; /* 버튼 간격 */
		width: 100%; /* 버튼 그룹이 전체 폭을 차지하도록 설정 */
	}

</style>
<body>
<div class="body">
<div class="jbb-title">
	<div class="title-left">
	    <button type="button" class="backbtn" onclick="history.back()"><</button>
	    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
    </div>
    <h2>마이페이지</h2>
    <%@ include file="/WEB-INF/views/timeout.jsp" %>
</div>
<div class="container"> 
<form action="<c:url value='/user/update'/>" id="action_form" method="post" onsubmit="return validateForm()">
    <div class="input-group">
    	<label>아이디</label>
    	<input type="text" id="id" name="id" value="${userdto.id}" readonly>
    </div>
    <div class="input-group">
    	<label>비밀번호</label>
    	<input type="password" id="pwd" name="pwd" oninput="pwCheck()" value="${userdto.pwd}">
    </div>
    <div><span id="result_checkpass" style="font-size:12px;"></span></div>
    <div class="input-group">
    	<label>비밀번호확인</label>
    	<input type="password" id="pwd2" name="pwd2" onkeyup = "passwordCheck()" placeholder="비밀번호를 다시 입력해주세요">
    </div>
    <div class="error_msg"><span id="passMsg"></span></div>
    <div class="input-group">
    	<label>이름</label>
    	<input type="text" id="name" name="name" value="${userdto.name}">
    </div>
    <div class="input-group">
    	<label>이메일</label>
    	<input class="input-field" type="text" id="email" name="email" value="${userdto.email}"> 
    </div>
    <div class="input-group">
    	<label>전화번호</label>
    	<input class="input-field" type="text" id="tel" name="tel" value="${userdto.tel}">
    </div>
    <div class="clearfix">
      <button type="submit">수정</button>
      <button type="button" id="removeBtn" class="removeBtn">탈퇴</button>
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

<!-- 에러 msg -->
<script>
	let msg = "${msg}";
	if(msg=="MOD_ERR") alert("정보를 수정하지 못했습니다. 다시 시도해주세요.")
	if(msg=="DEL_ERR") alert("탈퇴하지 못했습니다. 다시 시도해주세요.")
</script>

<!-- pwd, pwd2 일치 확인 -->
<script>
function passwordCheck(){
	let pwd = $("#pwd").val();
	let pwd2 = $("#pwd2").val();
	
	if (pwd != pwd2){
		res = "비밀번호가 일치하지 않습니다";
		$("#passMsg").html(res).css("color", "red");
		return false;
	} else {
		res = "비밀번호가 일치합니다";
		$("#passMsg").html(res).css("color", "green");
		return true;
	}
}
</script>

<!-- 비밀번호 길이 제한 -->
<script>
	function pwCheck(){
		let pwd = $("#pwd").val();
		
		if(pwd.length < 4 ){
			res = "비밀번호는 4자리 이상 10자리 이하여야 합니다"
			$("#result_checkpass").html(res).css("color", "red");
			return false;
		} else if(pwd.length > 10){
			res = "비밀번호는 4자리 이상 10자리 이하여야 합니다";
			$("#result_checkpass").html(res).css("color", "red");
			$("#pwd").val("").trigger("focus");
			return false;
		}
		else {
			res = "사용가능한 비밀번호입니다";
			$("#result_checkpass").html(res).css("color", "green");
		}
	}
</script>

<!-- 유효성 검사 -->
<script>
function validateForm(){
	let pwd = $("#pwd").val();
	let pwd2 = $("#pwd2").val();
	
	if(pwd==""||pwd.length<4||pwd.length>10){
		alert("비밀번호를 다시 확인해주세요");
		return false;
	} else if(pwd2=="" || pwd!=pwd2){
		alert("비밀번호 확인란을 다시 확인해주세요");
		return false;
	}
}
</script>

<!-- 회원 탈퇴 -->
<script>
$(document).ready(function(){
	$("#removeBtn").bind("click",function(){
		if(confirm("정말 탈퇴하시겠습니까?")){
			$("#action_form").attr("action", "${path }/user/delete");
			$("#action_form").attr("method", "post");
			$("#action_form").submit();
		}
	});
});
</script>
</body>
</html>