<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	
	.qna-detail {
		margin-top:50px;
		width: 900px;
	}	
	
	.question-box,
	.answer-box {
	    width: 100%;
	    font-size: 30px;
	    display: flex;
	    flex-direction: column;
	    justify-content: space-between; /* 내용과 날짜 사이에 공간을 배치 */
	    padding-bottom: 10px;
	}
	
	.question-box {
	    height: 200px;
	    border-bottom: 5px solid #ccc;
	}
	
	.answer-box {
	    height: 200px;
	    margin-top:20px;
	    background-color: #ddd;
	}
	
	.question-box p, .answer-box p {
	    white-space: pre-line; /* 줄바꿈을 유지 */
	}
	
	.bottom{
		font-size:25px;
		text-align: right;
		margin-right:50px;
	}
	
	.no-answer {
	    font-size: 25px;
	    text-align: center;
	    color: #FF8C00; /* 답변 없을 경우 강조 색상 */
	}
	
	.question-box, .answer-box {
	    min-height: 50px; /* 최소 높이 */
	    height: auto; /* 내용이 길어지면 자동 확장 */
	    transition: all 0.3s ease-out; /* 부드러운 효과 */
	    overflow: visible; /* 내용이 넘치면 보이도록 설정 */
	}
	
	.no-answer {
	    color: gray;
	}
	
	.delBtn{
		width:90px;
		height:70px;
		font-size:30px;
		font-weight:bold;
		color: #FF8C00;
		background-color:white;
		border: 2px solid #FF8C00;
	}
</style>
<body>
<%-- 질문 작성자와 현재 로그인한 사용자를 비교 --%>
<c:choose>
    <c:when test="${loggedInUser eq qnaDetail.question_writer}">
        <div class="container">
            <div class="jbb-title">
                <div class="title-left">
                    <button type="button" class="backbtn" onclick="history.back()"><</button>
                    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
                </div>
                <h2>문의 내용</h2>
                <%@ include file="/WEB-INF/views/timeout.jsp" %>
                <c:if test="${loggedInUser eq qnaDetail.question_writer}">
				    <form action="<c:url value='/qna/delete'/>" method="post">
				        <input type="hidden" name="qno" value="${qnaDetail.question_id}">
				        <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');" class="delBtn">삭제</button>
				    </form>
				</c:if>
            </div>
            <div class="qna-detail">
                <!-- 질문 내용 -->
                <div class="question-box">
                    <p>${qnaDetail.q_content}</p>           
                    <p class="bottom"><fmt:formatDate pattern="yyyy. M. dd" value="${qnaDetail.question_date}"/></p>
                </div>

                <!-- 답변이 있을 경우 출력 -->
                <c:if test="${not empty qnaDetail.a_content}">
                    <div class="answer-box">
                        <p>${qnaDetail.a_content}</p>                
                        <p class="bottom"><fmt:formatDate pattern="yyyy. M. dd" value="${qnaDetail.answer_date}"/></p>
                    </div>
                </c:if>

                <!-- 답변이 없을 경우 -->
                <c:if test="${empty qnaDetail.a_content}">
                    <p class="no-answer">아직 답변이 등록되지 않았습니다.</p>
                </c:if>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <%-- 본인이 작성한 문의가 아닌 경우 --%>
        <script>
            alert("본인이 작성한 문의만 확인할 수 있습니다.");
            window.location.href = "<c:url value='/qna/list'/>";
        </script>
    </c:otherwise>
</c:choose>
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
<!-- 질문내용,답변내용 높이 자동 조절 -->
<script>
$(document).ready(function() {
    function adjustHeight() {
        $('.question-box, .answer-box').each(function() {
            $(this).css('height', 'auto'); // 높이를 자동으로 설정
        });
    }

    // 페이지 로드 후 높이 조정
    adjustHeight();

    // 비동기 데이터 로딩 후 높이 재조정
    $(document).ajaxComplete(function() {
        adjustHeight();
    });
});
</script>
<script>
  let msg = "${msg}";
  if(msg=="DEL_ERR") alert("문의를 삭제하지 못했습니다. 다시 시도해 주세요.");
</script>
</body>
</html>