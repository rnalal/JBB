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
		margin-top:20px;
		margin-bottom:30px;
	} 
	
	.img_wrap{
		position:relative;
	}
	
	.slider{
		position: relative;
		display:flex;
		width:500px;
		overflow:hidden;
	}
	
	.img img {
	    width: 500px; 
		height:500px;
	    display:flex;
	    justify-content:center;
	}
	
	.slider-wrapper {
	    display: flex;
	    position: relative;
	    transition: transform 0.5s ease-in-out; /* 부드러운 애니메이션 효과 */
	    width: 100%;
	}
	
	.arrow button{
		position: absolute;
	    top: 50%;
	    transform: translateY(-50%);
	    background: rgba(169, 169, 169, 0.5);
	    color: white;
	    border: none;
	    padding: 10px;
	    cursor: pointer;
	    font-size: 25px;
	    z-index: 10; /* 이미지 위로 표시되도록 */
	}
	
	.prev {
	    left: 10px;
	}
	
	.next {
	    right: 10px;
	}
	
	.number{
		color: #FF8C00;
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
        <div class="qna-title">
            <span class="name"><a class="number">${boardDto.bno}</a> 번 게시물</span>
        </div>
        <div class="qnadetail">
            <div class="img_wrap">            
                <div class="slider">
                    <div class="slider-wrapper">
                        <c:set var="img_cnt" value="0" />
                        <div class="img">
                             <c:choose>
								<c:when test="${not empty boardDto.img1}">
									<img src="${data_path}/upload/${boardDto.img1}" alt="대표 이미지">
								</c:when>
								<c:otherwise>
									<img src="${data_path}/img/default_img.png" alt="기본 이미지">
								</c:otherwise>
							</c:choose>
                        </div>
                        <c:if test="${not empty boardDto.img2}">
                             <c:set var="img_cnt" value="1" />
                             <div class="img">                                 
                                 <img src="${data_path}/upload/${boardDto.img2}">
                             </div>
                        </c:if>
                        <c:if test="${not empty boardDto.img3}">
                            <c:set var="img_cnt" value="2" />
                            <div class="img">
                              	<img src="${data_path}/upload/${boardDto.img3}">
                            </div>
                        </c:if>
                    </div>
                </div>
                <!-- 화살표는 이미지가 2개 이상일 때만 표시 -->
                <c:if test="${img_cnt > 0}">
	                <div class="arrow">
	                    <button class="prev">&lt;</button>
	                    <button class="next">&gt;</button>
	                </div>
                </c:if>
            </div>
			<hr class="vertical-line">
			<div class="question-details">
					<div><span class="info-name">번호</span><a class="info">${boardDto.bno}</a></div>
					<div><span class="info-name">제목</span><a class="info">${boardDto.title}</a></div>
					<div><span class="info-name">내용</span><a class="info">${boardDto.content}</a></div>
					<div><span class="info-name">작성자</span><a class="info">${boardDto.writer}</a></div>
					<div><span class="info-name">작성일</span><a class="info"><fmt:formatDate pattern = "yyyy.MM.dd" value="${boardDto.reg_date}"/></a></div>
			</div>
		</div>
		<form action="<c:url value='/admin/admin_boardremove'/>" method="post">
			<input type="hidden" name="bno" value="${boardDto.bno}">
			<button type="submit" onclick="return confirm('정말 삭제하시겠습니까?');" class="delBtn">삭제</button>
		</form>
	</div>
</div>
<!-- 이미지 슬라이드 -->
<script>
$(document).ready(function(){
	var imgCount = ${img_cnt};  // img_cnt 변수를 사용하여 이미지 개수 가져오기
    var imgWidth = 500;  // 각 이미지 너비
    console.log("imgCount",imgCount)
    
 	// img_wrap의 width를 img_cnt에 맞게 동적으로 설정
    $(".slider-wrapper").css("width", imgWidth * imgCount);
    
	//오른쪽 화살표를 클릭하면 slider가 left기준으로 -500만큼 이동
	var num = 0;
	function img_move(){
		$(".slider-wrapper").stop().animate({
			left:-num*imgWidth
		});
	}
	$(".next").click(function(){
		num++;
		if(num > imgCount){
			num = 0;
		}
		img_move();
	});
	$(".prev").click(function(){
		num--;
		if(num < 0){
			num = imgCount - 1;
		}
		img_move();
	});
});
</script>
<script>
	let msg = "${msg}";
	if(msg=="AMDEL_ERR") alert("게시물 삭제에 실패했습니다. 다시 시도해주세요.");
</script>
</body>
</html>