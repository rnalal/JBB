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
		align-items: stretch; /* 높이를 동일하게 맞춤 */
		gap:20px;
		min-height: 100vh;
	}
	
	.menu-container {
		flex-shrink: 0; /* 사이드메뉴 크기 고정 */
		width: 250px;
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
	
	.faqdetail{
		width:100%;
		display:flex;
		flex-direction: column;
		gap:50px;
		font-size:20px;
		color: #5a5a5a;
		margin-top:40px;
	}
	
	.info-name{
		display:inline-block;
		min-width:100px;
		vertical-align: top;
	}
	
	.info-question{
		display: inline-block; /* 블록처럼 동작하도록 변경 */
		border: 1px solid #5a5a5a;
		text-decoration:none;
		width:600px;
		height:auto;
		margin-left:40px;
		white-space: pre-wrap;
		padding:10px;
	}
	
	.info-answer{
		display: inline-block; /* 블록처럼 동작하도록 변경 */
		border: none;
		text-decoration:none;
		background-color:#ddd;
		width:600px;
		height:auto;
		margin-left:40px;
		white-space: pre-wrap;
		padding:10px;
	}
	
	.info{
		display: inline-block; /* 블록처럼 동작하도록 변경 */
		border-bottom: 1px solid #5a5a5a;
		text-decoration:none;
		width:600px;
		height:auto;
		margin-left:40px;
		white-space: pre-wrap;
		padding:10px;
	}
	
	.info-title{
		font-size:25px;
		font-weight:bold;
		color:#5a5a5a;
	}	
		
	.bottom{
		display:flex;
		gap:20px;
		height:50px;
		margin-top:50px;
	}
	
	.removeBtn {
		width:400px;
		height:50px;
		font-size:20px;
		font-weight:bold;
		color: #FF8C00;
		background-color:white;
		border: 2px solid #FF8C00;
	}
	
	.modifyBtn{
		width:400px;
		height:50px;
		font-size:20px;
		font-weight:bold;
		background-color: #FF8C00;
		color:white;
		border:none;
	}
	
	.name{
		color:#FF8C00;
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
	<span class="info-title"><a class="name">${faqDto.fno}</a>번 FAQ</span>
		<div class="faqdetail">
			<div><span class="info-name">질문</span><a class="info-question">${faqDto.f_question}</a></div>
			<div><span class="info-name">답변</span><a class="info-answer">${faqDto.f_answer}</a></div>
			<div><span class="info-name">작성일</span><a class="info"><fmt:formatDate pattern = "yyyy.MM.dd" value="${faqDto.f_date}"/></a></div>
		</div>
		<div class="bottom">
			<button type="button" id="removeBtn" class="removeBtn">FAQ삭제</button>
		    <form action="${path}/admin/faqmodify?page=${param.page}&pageSize=${param.pageSize}" method="get">
			    <input type="hidden" name="fno" value="${faqDto.fno}">
			    <button type="submit" class="modifyBtn">FAQ수정</button>
			</form>
		</div>
	</div>	
</div>	
<script>
//삭제버튼
$('#removeBtn').on("click", function(){
	if(!confirm("정말로 삭제하시겠습니까?")) return;
	
	$.ajax({
		url:"<c:url value='/admin/faqdelete'/>",
		type:"POST",
		data: {fno: "${faqDto.fno}"},
		success: function(response){
			alert("삭제되었습니다.");
			window.location.href = "<c:url value='/admin/admin_faqlist'/>"; 
		},
		error: function(xhr, status, error){
			alert("삭제 실패:" + error);
		}
	});
});
</script>
</body>
</html>