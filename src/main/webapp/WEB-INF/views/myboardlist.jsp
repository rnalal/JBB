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
		text-align:center;
		display: flex; /* 플렉스 컨테이너로 설정 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    margin: 0; /* 기본 여백 제거 */
	    text-align: center; /* 내부 텍스트 가운데 정렬 */
	}
	
	.container {
		width: 900px;
		margin: 0 auto;
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
	
	.board-list {
		display: grid;
		grid-template-columns: repeat(2, 1fr); /* 2열 구조 */
		gap: 15px; /* 아이템 간격 */
		margin-top: 30px;
	}
	
	.board-item {
		background: #fff;
		padding: 15px;
		border-radius: 10px;
		text-align: center;
		margin-bottom:60px;
	}
	
	 .board-item img {
        width: 100%; /* 이미지 너비를 부모 요소에 맞춤 */
        height: 400px; /* 고정된 높이 */
        object-fit: cover; /* 비율 유지하며 자르기 */
        border-radius: 10px;
    }

    .board-item p {
        margin: 10px 0;
        font-size: 30px;
        color:#5a5a5a;
        font-weight:bold;
    }

    .board-item .date {
        color: gray;
        font-size: 25px;
        text-align:right;
    } 
    
    .imgtop {
    	display:flex;
    	text-align:left;
    }
    
    .bname {
    	display:flex;
    	color:#FF8C00;
    	font-size:30px;
    	font-weight:bold;
    }
    
    .icon {
    	font-size:40px;
    }
    
    /* 하단바 */
    .bottom-bar {
        position: fixed;
        bottom: 0px;
        left: 0;
        width: 100%;
        background: #5a5a5a;
        text-align: center;
        padding: 10px 0;
        display: flex;
        justify-content: space-around;
        z-index: 100; /* 화살표보다 위에 표시 */
   }

   .bottom-bar a {
        color: white;
        text-decoration: none;
        font-size: 30px;
        font-weight:bold;
   }
</style>
</head>
<body>
<div class="container">
	<div class="jbb-title">
		<div class="title-left">
		    <button type="button" class="backbtn" onclick="history.back()"><</button>
		    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
	    </div>
		<h2>내가 작성한 글</h2>
		<%@ include file="/WEB-INF/views/timeout.jsp" %>
	</div>
	<!-- 게시글 리스트 (그리드 레이아웃 적용) -->
    <div class="board-list">
        <c:forEach var="boardDto" items="${list}">
            <div class="board-item">
            	<div class="imgtop">
            		<span class="bname"><span class="icon">🏷️</span>${boardDto.bc_name}</span>
            	</div>
            	<a href="<c:url value='/board/read?bno=${boardDto.bno}'/>">
                	<c:choose>
						<c:when test="${not empty boardDto.img1}">
							<img src="${data_path}/upload/${boardDto.img1}" alt="대표 이미지">
						</c:when>
						<c:otherwise>
							<img src="${data_path}/img/default_img.png" alt="기본 이미지">
						</c:otherwise>
					</c:choose>
                </a>
                <p>
	                <c:choose>
						<c:when test="${fn:length(boardDto.title) > 10}">
							${fn:substring(boardDto.title, 0, 10)}...
						</c:when>	
						<c:otherwise>
							${boardDto.title}
						</c:otherwise>
					</c:choose>
				</p>
                <p class="date"><fmt:formatDate pattern = "yyyy. M. dd" value="${boardDto.reg_date}"/></p>
            </div>
        </c:forEach>
    </div>
    <!-- 로그인 후에만 보이는 하단바 -->
	<c:if test="${not empty id}">
		<div class="bottom-bar" id="bottom-bar">
			<a href="<c:url value='/board/myboardlist'/>"><span class="icon">✏️</span> 내 글 보기</a>
			<a href="<c:url value='/board/mycommentlist'/>"><span class="icon">💬</span> 내 댓글 보기</a>
			<a href="<c:url value='/board/mylikeslist'/>"><span class="icon">❤️</span> 좋아요 한 글</a>
		</div>
	</c:if>
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
</div>
</body>
</html>