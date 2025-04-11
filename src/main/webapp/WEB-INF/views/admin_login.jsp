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
	body {
		background-color: #5a5a5a;
		display:flex;
		justify-content: center;
		align-items:center;
		height:100vh;
		maring:0;
	}
	
	.form {
		width:300px;
		display:flex;
		flex-direction:column;
	}
	
	.title{
		font-size:50px;
		font-weight:bold;
		color:#FF8C00;
		width:100%;
		text-align:center;
		margin-bottom:10px;
	}
	
	.url {
		text-decoration:none;
		color:#FF8C00;
		margin-right:10px;
	}
	
	.sub_title{
		color:white;
		font-size:25px;
	}
	
	.form input{
		width:100%;
		height:50px;
		font-size:20px;
	}
	
	.form button {
		width:100%;
		height:50px;
		font-size:20px;
		margin-top:20px;
		background-color:#FF8C00;
		color:white;
		border:none;
		cursor: pointer;
	}
</style>
</head>
<body>
<div class="form">
<div class="title"><a href="<c:url value='/' />" class="url">JBB</a><a class="sub_title">for admin only</a></div>
	<form action="<c:url value='/adminlogin'/>" method="post" onsubmit="return validateForm()">  
	       <input type="text" id="id" name="id" value="${cookie.id.value }" placeholder="아이디 입력" autofocus>
	       <input type="password" id="pwd" name="pwd" placeholder="패스워드 입력">	
	       <button type="submit">로그인</button>
	</form>
</div>
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