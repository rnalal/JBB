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
	
	.detail-container{
		margin-top:30px;
		margin-left:30px;
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
	
	.name{
		color:#FF8C00;
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
	<div class="detail-container">
	<span class="info-title"><a class="name">${notifyDto.nno}</a>번 공지사항 수정</span>
		<div class="container">
			<form action="<c:url value='/admin/notifymodify?page=${param.page}&pageSize=${param.pageSize}'/>" method="post" id="form" onsubmit="return validateForm()">
				<input type="hidden" name="nno" value="${notifyDto.nno}">	
				<div class="input-group">
		            <input type="text" name="ntitle" id="ntitle" value="${notifyDto.ntitle}">
		        </div>
				<div class="input-group">
		            <textarea name="ncontent" id="ncontent" rows="1">${notifyDto.ncontent}</textarea>
		        </div>
				<div class="input-group">
					<button type="submit" class="submit">수정</button>
				</div>
			</form>
		</div>
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
  if(msg=="MOD_OK") alert("공지사항이 수정되었습니다.");
  if(msg=="MOD_ERR") alert("수정에 실패했습니다.");
</script>
</body> 
</html>