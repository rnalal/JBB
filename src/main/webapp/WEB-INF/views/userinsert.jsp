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
	
	.detail-container{
		flex-grow:1;
		text-align:left;
		margin-top:50px;
		margin-left:150px;
	}
	
	.userinsert{
		width:100%;
		display:flex;
		flex-direction: column;
		gap:30px;
		margin-top:40px;
	}
	
	.info-title{
		font-size:25px;
		font-weight:bold;
		color:#5a5a5a;
	}
	
	.signupbtn{
		width:100px;
		height:50px;
		font-size:20px;
		font-weight:bold;
		color: #FF8C00;
		background-color:white;
		border: 2px solid #FF8C00;
		margin-left:20px; 
	}
	
	label {
		font-size:20px;
		color:#5a5a5a;
		display:inline-block;
		min-width:150px;
	}
	
	.input-group input{
		width:600px;
		border:none;
		border-bottom: 1px solid #5a5a5a;
		font-size:20px;
	}
</style>
</head>
<body>
<div class="top-bar">
	<div class="title">
		<span class="main-title">JBB</span>
		<span class="side-title">for admin only</span>
	</div>
</div>
<div class="content-container">	
	<%@ include file="side-menu.jsp" %>
	<div class="detail-container">
	<form action="<c:url value='/admin/userinsert'/>" method="post" onsubmit="return validateForm()"> 
	   <span class="info-title">사용자 등록</span>
	   <button type="submit" class="signupbtn">등록하기</button>
	   <div class="userinsert"> 
		   <div class="input-group">
		    	<label>아이디</label>
		    	<input type="text" id="id" name="id" oninput = "checkId()" placeholder="아이디를 입력하세요" >
		    </div>
		    <div class="error_msg"><span id="result_checkId"></span></div>  
		    <div class="input-group">  
		    	<label>비밀번호</label>
		   	 	<input type="password" id="pwd" name="pwd" oninput="pwCheck()" placeholder="비밀번호를 입력해주세요">
		   	</div>
		    <div class="error_msg"><span id="result_checkpass"></span></div>
		    <div class="input-group">
		    <label>비밀번호확인</label>
		    <input type="password" id="pwd2" name="pwd2" onkeyup = "passwordCheck()" placeholder="비밀번호를 다시 입력해주세요">
		    </div>
		    <div class="error_msg"><span id="passMsg"></span></div>
		    <div class="input-group">
		    <label>이름</label>
		    <input type="text" id="name" name="name" placeholder="이름을 입력해주세요">
		    </div>
		    <div class="input-group">
		    <label>이메일</label>
	    	<input type="text" id="email" name="email" placeholder="이메일을 입력해주세요"> 
	    	</div>
	    	<div class="input-group">
	    	<label>전화번호</label>
	    	<input type="text" id="tel" name="tel" placeholder="000-0000-0000">
			</div>	
		</div>	  	 
	</form>
	</div>
<!-- msg -->
<script>
	let msg = "${msg}";
	if(msg=="INSERT_ERR") alert("사용자등록에 실패했습니다. 다시 시도해주세요.")
</script>
<!-- 아이디 중복확인 Ajax -->
<script>
function checkId(){

		let id = $("#id").val();
		
		if(id=='' || id.length == 0){
			result = "아이디를 입력해주세요";
			$("#result_checkId").html(result).css("color", "red");
			return false;
		} else if (id.length < 3){
			result = "아이디는 3자리 이상 10자리 이하여야 합니다";
			$("#result_checkId").html(result).css("color", "red");
			return false;
		} else if (id.length > 10){
			result = "아이디는 3자리 이상 10자리 이하여야 합니다";
			$("#result_checkId").html(result).css("color", "red");
			$("#id").val("").trigger("focus");
			return false;
		}
		
		$.ajax({
			type:'post',
			url:'checkuserId',
			data:{"id":id},
			success: function(data){
				if(data == "N"){
					result = "사용 가능한 아이디입니다";
					$("#result_checkId").html(result).css("color", "green");
				} else {
					 result="이미 사용중인 아이디입니다";
                     $("#result_checkId").html(result).css("color","red"); 
				}
			},
			error : function(error){alert(error);}
		});
};
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
		let id = $("#id").val();
		let pwd = $("#pwd").val();
		let pwd2 = $("#pwd2").val();
		let name = $("#name").val();
		let email = $("#email").val();
		let tel = $("#tel").val();
		
		if(id=="" || id.length<3 || id.length>10){
			alert("아이디를 다시 확인해주세요");
			return false;
		} else if(pwd=="" || pwd.length<4 || pwd.length>10){
			alert("비밀번호를 다시 확인해주세요");
			return false;
		} else if(pwd2=="" || pwd!=pwd2 ){
			alert("비밀번호 확인란을 다시 확인해주세요");
			return false;
		} else if(name==""){
			alert("이름을 입력해주세요");
			return false;
		} else if(email==""){
			alert("이메일을 입력해주세요");
			return false;
		} else if(tel==""){
			alert("전화번호를 입력해주세요");
			return false;
		}
	}
</script>
</div>	
</body>
</html>