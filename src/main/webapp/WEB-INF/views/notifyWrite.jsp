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
</head>
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
	
	.user-table-container{
		flex-grow:1; /*남은 공간을 전부 차지*/
		margin-left:20px;
		margin-top:30px;
	}
	
	.info-title{
		font-size:30px;
		font-weight:bold;
		color:#5a5a5a;
	}
	
	.input-group{
		margin-top:20px;
		width:1000px;
	}
	
	input{
		height:50px;
		border: 1px solid #5a5a5a;
		border-radius: 4px;
	}
	
	textarea{
		height:300px;
		resize: none; 
		border: 1px solid #5a5a5a;
		border-radius: 4px;
	}
	
	input, textarea{
		width:100%;
		font-size:20px;
	}
	
	.submit{
		width:100%;
		height:50px;
		font-size:20px;
		font-weight:bold;
		background-color:#FF8C00;
		color:white;
		border:none;
		border-radius: 4px;
	}
</style>
<body>
<div class="top-bar">
	<div class="title">
		<span class="main-title">JBB</span>
		<span class="side-title">for admin only</span>
	</div>
</div>
<div class="content-container">	
	<%@ include file="side-menu.jsp" %>
	<div class="user-table-container">
	<span class="info-title">공지사항 작성</span>
		<form action="<c:url value='/admin/notifywrite'/>" method="post" id="form" onsubmit="return validateForm()">
			<input type="hidden" name="nno" value="${notifyDto.nno}">	
			<div class="input-group">
				<input type="text" name="ntitle" id="ntitle" placeholder="제목을 입력하세요">
			</div>
			<div class="input-group">
				<textarea name="ncontent" id="ncontent" rows="1" placeholder="자유롭게 내용을 입력하세요"></textarea>
			</div>
			<div class="input-group">
				<button type="submit" class="submit">등록</button>
			</div>
		</form>
	</div>
</div>
<!-- 유효성 검사 -->
<script>
	function validateForm(){
		let ntitle = $("#ntitle").val();
		let ncontent = $("#ncontent").val();
		
		if(ntitle==""&&ncontent==""){
			alert("게시글 제목과 내용을 입력해주세요");
			return false;
		} else if(ntitle==""){
			alert("게시글 제목을 입력해주세요");
			return false;
		} else if(ncontent==""){
			alert("게시글 내용을 입력해주세요");
			return false;
		}
	}
</script>
<script>
  let msg = "${msg}";
  if(msg=="WRT_ERR") alert("공지사항 등록을 실패했습니다.");
</script>
</body>
</html>