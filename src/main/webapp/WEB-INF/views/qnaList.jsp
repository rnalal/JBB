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

	/* 테이블 스타일 */
	.qna-table {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 50px;
	}

	.qna-table th, .qna-table td {
	    padding: 20px;
	    text-align: center;
	    border-bottom: 1px solid #ddd;
	}
	
	.qna-table th {
	    background: #FF8C00;
	    color: white;
	    font-size:30px;
	}
	
	.qna-table td{
		padding: 50px;
		font-size:25px;
		cursor: pointer;
	}

	/* 답변 상태 스타일 */
	.status {
	    font-weight: bold;
	    padding: 5px 10px;
	    border-radius: 5px;
	}

	.pending {
	    color: #FF8C00;
	    font-weight:bold;
	}
	
	.content{
		width:500px;
	}
	
	.status{
		width:200px;
	}
	
	.qna-date {
	    color: #999; /* 연한 회색 */
	    font-size: 25px; /* 제목보다 작은 글씨 */
	    display: block; /* 줄 바꿈 */
	    text-align: right; /* 오른쪽 정렬 */
	    margin-bottom: 5px; /* 제목과 간격 조정 */
	    position: relative; 
    	top: 30px; /* 아래쪽으로 내리기 */
	}
	
	button.writebtn {
	    position: fixed; /* 고정 위치 */
	    bottom: 2vh; /* 화면 하단에서 2% 위치 */
	    right: 2vw; /* 화면 오른쪽에서 2% 위치 */
	    background-color: #FF8C00; /* 버튼 배경색 */
	    color: white;
	    padding: 20px 40px; /* 내부 여백 */
	    border: none;
	    border-radius: 50px; /* 둥근 모서리 */
	    font-size: 80px;
	    cursor: pointer;
	    z-index: 1000; /* 항상 위에 표시 */
	    transition: all 0.3s ease-in-out; /* 크기/위치 전환 효과 */
	}
</style>
<body>
<div class="container">
    <div class="jbb-title">
        <div class="title-left">
            <button type="button" class="backbtn" onclick="history.back()"><</button>
            <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
        </div>
        <h2>문의게시판</h2>
        <%@ include file="/WEB-INF/views/timeout.jsp" %>
    </div>
    <table class="qna-table">
        <thead>
            <tr>
                <th class="content">문의 내용</th>
                <th class="status">답변 상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="qnaDto" items="${list}">
	                <tr onclick="location.href='${path}/qna/detail?qno=${qnaDto.qno}'">
	                    <td>                   
			                <c:choose>
								<c:when test="${fn:length(qnaDto.q_content) > 20}">
									${fn:substring(qnaDto.q_content, 0, 20)}...
								</c:when>	
								<c:otherwise>
									${qnaDto.q_content}
								</c:otherwise>
							</c:choose>
						    <span class="qna-date">
						        <fmt:formatDate pattern="yyyy. M. dd" value="${qnaDto.qna_date}"/>
						    </span>
	                    </td>
	                    <td>
	                       <c:choose>
							    <c:when test="${qnaDto.is_answered}">
							        <span class="answered">답변 완료</span>
							    </c:when>
							    <c:otherwise>
							        <span class="pending">답변 대기</span>
							    </c:otherwise>
							</c:choose>
	                    </td>
	                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<!-- 글쓰기 버튼 -->
<button type="button" class="writebtn "id="writeBtn" onclick="location.href='<c:url value="/qna/qwrite"/>'">+</button>
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
<script>
  let msg = "${msg}";
  if(msg=="QWRT_OK") alert("문의가 성공적으로 등록되었습니다.");
  if(msg=="DEL_OK") alert("문의가 성공적으로 삭제되었습니다.");
</script>
</body>
</html>