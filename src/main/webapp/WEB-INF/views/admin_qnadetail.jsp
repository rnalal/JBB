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
	
	.qna-title{
		width:100%;
		display:flex;
		aligh-items: center; /* 세로 중앙 정렬 */
		justify-content: space-between;
		gap: 20px;
	}
	
	.name{
		font-size:25px;
		font-weight:bold;
		color:#5a5a5a;
	}
	
	.name_answer{
		font-size:25px;
		font-weight:bold;
		color:#FF8C00;
	}
	
	.qna-table-container{
		margin-top:40px;
		margin-left:40px;
	}
	
	.qnadetail{
		width:100%;
		display:flex;
		flex-direction: row; 
		gap:40px;
		font-size:20px;
		color: #5a5a5a;
		margin-top:40px;
	}
	
	.question-details{
		display:flex;
		flex-direction: column; 
		gap:50px;
	}
	
	.info-name{
		display:inline-block;
		min-width:150px;
		vertical-align: top;
	}
	
	.info{
		display: inline-block; /* 블록처럼 동작하도록 변경 */
		border-bottom: 1px solid #5a5a5a;
		text-decoration:none;
		width:300px;
		margin-left:40px; 
		white-space: pre-wrap; /* 줄바꿈과 공백을 그대로 유지 */
	}
	
	.answer-form {
		flex-shrink: 0;
		width: 500px; /* 답변 폼의 너비 설정 */
		height:500px;
		display: flex;
    	flex-direction: column;
	}
	
	.answer-form textarea {
		width: 100%;
		height: 100%;
		margin-top: 20px;
		padding: 10px;
		border: 1px solid #5a5a5a;
		border-radius: 4px;
		font-size: 20px;
		resize: none; /* 크기 조정 비활성화 */
	}
	
	.answer-form button {
		width: 100%;
		padding: 10px;
		background-color: #FF8C00;
		color: white;
		border: none;
		border-radius: 4px;
		cursor: pointer;
		margin-top: 50px;
		font-size:20px;
	}
	
	.delBtn {
		width: 100%;
		padding: 10px;
		background-color: white;
		color: #FF8C00;
		border: 2px solid #FF8C00;
		border-radius: 4px;
		cursor: pointer;
		margin-top: 10px;
		font-size:20px;
	}
	
	.answer-section {
		width: 350px; /* 답변 섹션 너비 */
		padding: 10px;
		border: 1px solid #ddd;
		border-radius: 4px;
		background-color: #f9f9f9;
	}
	
	.answer-section h3 {
		margin-top: 0;
		font-size: 20px;
		font-weight: bold;
		color: #FF8C00;
	}
	
	.answer-section p {
		font-size: 16px;
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
	<div class="qna-table-container">
		<c:if test="${not empty qnaDto}">
			<div class="qna-title">
			    <span class="name">${qnaDto.question_id} 번 문의내용</span>
			    <label for="a_content" class="name_answer">답변</label>
		    </div>
		    <div class="qnadetail">
			    <div class="question-details">
					<div><span class="info-name">번호</span><a class="info">${qnaDto.question_id}</a></div>
					<div><span class="info-name">문의내용</span><a class="info">${qnaDto.q_content}</a></div>
					<div><span class="info-name">작성자</span><a class="info">${qnaDto.question_writer}</a></div>
					<div><span class="info-name">작성일</span><a class="info"><fmt:formatDate pattern = "yyyy.MM.dd" value="${qnaDto.question_date}"/></a></div>
					<form action="<c:url value='/admin/qnadelete?page=${param.page}&pageSize=${param.pageSize}'/>" method="post">
				        <input type="hidden" name="qno" value="${qnaDto.question_id}">
				        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');" class="delBtn">질문 삭제</button>
				    </form>
				</div>
				<hr class="vertical-line">
				<!-- 답변 입력 폼 -->
				<c:if test="${empty qnaDto.a_content}">
					<div class="answer-form">
						<form action="${path}/admin/qnaAnswer" method="post">
							<input type="hidden" name="parent_id" value="${qnaDto.question_id}"> <!-- 질문의 qno를 parent_id로 넘김 -->
							<input type="hidden" name="writer" value="관리자">														
							<textarea id="a_content" name="a_content" rows="4" cols="50" required placeholder="답변을 입력해주세요"></textarea>							
							<button type="submit">답변등록</button>
						</form>
					</div>
				</c:if>
				<!-- 답변이 있으면 표시 -->
				<c:if test="${not empty qnaDto.a_content}">
					<div class="question-details">
						<div><span class="info-name">번호</span><a class="info">${qnaDto.answer_id}</a></div>
						<div><span class="info-name">답변내용</span><a class="info">${qnaDto.a_content}</a></div>
						<div><span class="info-name">작성자</span><a class="info">${qnaDto.answer_writer}</a></div>
						<div><span class="info-name">작성일</span><a class="info"><fmt:formatDate pattern = "yyyy.MM.dd" value="${qnaDto.answer_date}"/></a></div>
						<form action="<c:url value='/admin/answerdelete'/>" method="post">
					        <input type="hidden" name="parent_id" value="${qnaDto.parent_id}">
					        <input type="hidden" name="qno" value="${qnaDto.question_id}">
					        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');" class="delBtn">답변 삭제</button>
					    </form>
					</div>
				</c:if>
			</div>
		</c:if>
	</div>
<script>
	let msg = "${msg}";
	if(msg=="ANSWER_OK") alert("답변이 등록되었습니다.");
	if(msg=="ANSWER_ERR") alert("답변등록에 실패했습니다. 다시 시도해주세요.");
	if(msg=="QNADEL_ERR") alert("문의삭제에 실패했습니다. 다시 시도해주세요.");
	if(msg=="ANWDEL_OK") alert("답변 삭제에 성공했습니다.");
	if(msg=="ANWDEL_ERR") alert("답변 삭제에 실패했습니다. 다시 시도해주세요.");
</script>
</div>
</body>
</html>