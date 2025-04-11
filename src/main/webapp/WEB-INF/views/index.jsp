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

		/* 기본 스타일 초기화 */
	    *{
	         margin: 0;
	         padding: 0;
	         box-sizing: border-box;
	      }
	
	     /* 콘텐츠 영역 */
	     .content {
	         padding-top: 80px;
	         text-align: center;
	         justify-content: center;
	     }
        
        .header {
            display: flex;
		    align-items: center;
		    width:900px;
		    justify-content: space-between;
		    height: 90px;
		    background-color: white;
		    padding: 0 20px;
		    position: fixed;
		    top: 0;
		    left: 50%; /* 화면 중앙에 위치 */
		    transform: translateX(-50%); /* 중앙 정렬 */
		    z-index: 999; 
        }
        
        .logo {
        	width:900px;
            font-size: 60px;
            font-weight: bold;
            text-align:center;
            color: #FF8C00;
        }
        
        /* 햄버거 메뉴 버튼 */
        .hamburger {
            font-size: 50px;
    		cursor: pointer;
    		color: #FF8C00;
        }                

		/* 사이드바 스타일 */
        .sidebar {
		    width: 600px;  /* 사이드바 크기 */
		    height: 200vh;
		    position: fixed; /* 고정 위치 */
		    top: -90px;  /* 헤더(90px 높이)를 덮도록 위로 올림 */
		    left: -600px; /* 기본적으로 화면 밖에 위치 */
		    background-color: white;
		    transition: left 0.3s ease-in-out;  /* left 값 애니메이션 */
		    display: flex;
		    flex-direction: column;
		    padding-top: 170px;
		    z-index: 2000;
		}
        
       /* 사이드바 활성화 시 */
		.sidebar.active {
		    left:0px; 
		}  

        .sidebar a {
            display: block;
		    padding: 15px;
		    text-decoration: none;
		    font-size: 40px;  /* 글자 크기 확대 */
		    color: black;
		    transition: 0.3s;
		    text-align: center;
		    font-weight: bold;
        }
        
        .close-btn {
		    position: absolute;
		    top: 110px;
		    right: 15px;
		    font-size: 50px; /* 크기 키우기 */
		    cursor: pointer;
		    font-weight: bold;
		}
		
		/* 프로필 아이콘 */
        .profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }
        
        a.bottom {
		    color: #505050;
		    text-decoration: none;
		    margin-top: 10px;
            font-size: 40px;
            font-weight: bold;
		}
        
        .profile .links {
        	padding-top:20px;
		    display: flex;
		    align-items: center; /* 요소들을 수직 중앙 정렬 */
    		gap: 5px; /* 링크 사이 간격 */
		}
		
		.profile .links span {
		    font-size: 40px;
		    color: #505050;
		}
		
		.profile img {
            width: 300px;
            height: 300px;
            border-radius: 50%;
            background: #ddd;
        }
        
        .img_wrap{
			position: relative;
		    display: flex;  /* Flexbox 적용 */
		    justify-content: center;
		    align-items: center; /* 세로 방향 중앙 정렬 (필요한 경우) */
		    margin-top: 5px;
		    margin-bottom: 120px;
		}
		
		.slider{
			position: relative;
			display:flex;
			flex-direction: column;
			width:800px;
			overflow:hidden;
		}
		
		.ti {
        	width:100%;
        	display:flex;
        	flex-direction: column;
		    align-items: center;
		    margin-bottom:20px;
		    margin-top:30px;
        }
		
		.slider-title {
		    margin-top:30px;
		    font-size:35px;
		    font-weight:bold;
		    width:800px;
		    height:70px;
			text-align:left;
			color:#5a5a5a;
		}
		
		.slider-title2 {
		    font-size:25px;
		    font-weight:bold;
		    width:800px;
			text-align:left;
			color:#888;
		}
		
		.rank-label {
		    position: relative;
		    font-size: 30px;
		    font-weight: bold;
		    color: #FF8C00;
		    margin-right:20px;
		}
		
		.img {
		    position: relative; /* 부모 요소 기준으로 절대 위치 설정 가능 */
		}
				
		.img img {
		    width: 800px; 
			height:800px;
		    display:flex;
		    justify-content:center;
		    border: 1px solid #5a5a5a;
		}
		
		.img_title {
			color:#5a5a5a;
			font-weight:bold;
			font-size:30px;
			border-bottom:1px solid #5a5a5a;
			border-left:1px solid #5a5a5a;
			border-right:1px solid #5a5a5a;
			padding:10px;
		}
		
		.lat-slider-wrapper {
		    display: flex;
		    position: relative;
		    transition: transform 0.5s ease-in-out; /* 부드러운 애니메이션 효과 */
		    width: 100%;
		}
		
		.pop-slider-wrapper {
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
		    font-size: 40px;
		    z-index: 99;  /* 이미지 위에 올라오면서, 하단바보다 낮게 설정 */
		}

        .prev {
		    left: 10px;
		}
		
		.next {
		    right: 10px;
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
        
        .icon {
        	font-size:50px;
        }

</style>

<body>
     <!-- 헤더 -->
    <div class="header">
        <div id="hamburger" class="hamburger">☰</div>        	
        <div class="logo">JBB</div>
    </div>
	<%@ include file="/WEB-INF/views/timeout.jsp" %>
    <!-- 사이드바 -->
    <div class="sidebar" id="sidebar">
        <c:choose>
            <c:when test="${empty id}">
            	<span id="close-btn" class="close-btn">✖</span>
            	<div class="profile">
            	 	<img src="${data_path}/img/user_default.png" alt="기본사진">
            	 	<div class="links">
	                	<a href="<c:url value='/user/login'/>" class="bottom">로그인</a> 
	                	<span>|</span>
	                	<a href="<c:url value='/user/join'/>" class="bottom">회원가입</a>
                	</div>
                </div>
                <hr>
                <a href="<c:url value='/board/list'/>">커뮤니티</a>
                <a href="<c:url value='/notify/list'/>">공지사항</a>
                <a href="<c:url value='/faq/user_faqlist'/>">FAQ</a>
            </c:when>
            <c:otherwise>
            	<span id="close-btn" class="close-btn">✖</span>
            	<div class="profile">
            	 	<img src="${data_path}/img/user_default.png">
            	 	<div class="links">
	                	<a href="<c:url value='/user/logout'/>" class="bottom">로그아웃</a> 
	                	<span>|</span>
	                	<a href="<c:url value='/user/mypage'/>" class="bottom">마이페이지</a>
                	</div>
                </div>
                <hr>
                <a href="<c:url value='/board/list'/>">커뮤니티</a>
                <a href="<c:url value='/notify/list'/>">공지사항</a>
                <a href="<c:url value='/qna/list'/>">문의</a>
            </c:otherwise>    
        </c:choose>
    </div>   
    <!-- 콘텐츠 -->
    <div class="content">
		<!-- 최신글 슬라이더 -->
		<div class="ti">
			<h2 class="slider-title"> 🆕 가장 최근에 올라온 글은?!</h2>
			<h3 class="slider-title2">👥 최근에 올라온 글로 같이 소통해요!</h3>
		</div>
		<div class="img_wrap">
			<div class="slider">
				<div class="lat-slider-wrapper">
				     <c:forEach var="boardDto" items="${latestPosts}" varStatus="status">
				         <div class="img">
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
					         <p class="img_title"><span class="rank-label">🏆 ${status.index + 1}위</span>${boardDto.title}</p>
				         </div>
				      </c:forEach>
				 </div>
				 <div class="arrow">
				      <button class="prev">&lt;</button>
				      <button class="next">&gt;</button>
				 </div>
			</div>
		</div>
		<!-- 인기글 슬라이더 -->
		<div class="ti">
			<h2 class="slider-title">🔥 요즘 인기있는 글은?!</h2>
			<h3 class="slider-title2">👥 인기있는 게시글은 어떤게 있을까요?</h3>
		</div>
		<div class="img_wrap">
			<div class="slider">
				 <div class="pop-slider-wrapper">
				      <c:forEach var="boardDto" items="${popularPosts}" varStatus="status">
				           <div class="img">
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
				               <p class="img_title"><span class="rank-label">🏆 ${status.index + 1}위</span> ${boardDto.title}</p>
				            </div>
				      </c:forEach>
				  </div>
				  <div class="arrow">
				      <button class="prev">&lt;</button>
				      <button class="next">&gt;</button>
				 </div>
			</div>
		</div>
		<!-- 로그인 후에만 보이는 하단바 -->
		<c:if test="${not empty id}">
			<div class="bottom-bar" id="bottom-bar">
				  <a href="<c:url value='/board/myboardlist'/>"><span class="icon">✏️</span> 내 글 보기</a>
				  <a href="<c:url value='/board/mycommentlist'/>"><span class="icon">💬</span> 내 댓글 보기</a>
				  <a href="<c:url value='/board/mylikeslist'/>"><span class="icon">❤️</span> 좋아요 한 글</a>
			</div>
		</c:if>
     </div>     
</body>
<!-- 최신글, 인기글 슬라이더 -->
<script>
$(document).ready(function(){
    var latImgCount = ${fn:length(latestPosts)};
    var popImgCount = ${fn:length(popularPosts)};
    var imgWidth = 800;
    var latNum = 0;
    var popNum = 0;

    $(".lat-slider-wrapper").css("width", imgWidth * latImgCount);
    $(".pop-slider-wrapper").css("width", imgWidth * popImgCount);

    function latImgMove(){
        $(".lat-slider-wrapper").stop().animate({ left: -latNum * imgWidth });
    }
    function popImgMove(){
        $(".pop-slider-wrapper").stop().animate({ left: -popNum * imgWidth });
    }

    $(".lat-slider-wrapper").siblings(".arrow").find(".next").click(function(){
        latNum++;
        if(latNum >= latImgCount) latNum = 0;
        latImgMove();
    });

    $(".lat-slider-wrapper").siblings(".arrow").find(".prev").click(function(){
        latNum--;
        if(latNum < 0) latNum = latImgCount - 1;
        latImgMove();
    });

    $(".pop-slider-wrapper").siblings(".arrow").find(".next").click(function(){
        popNum++;
        if(popNum >= popImgCount) popNum = 0;
        popImgMove();
    });

    $(".pop-slider-wrapper").siblings(".arrow").find(".prev").click(function(){
        popNum--;
        if(popNum < 0) popNum = popImgCount - 1;
        popImgMove();
    });
});
</script>
<!-- 사이드 바 -->
<script>
document.addEventListener("DOMContentLoaded", function () {
		const sidebar = document.getElementById("sidebar");
		const hamburger = document.getElementById("hamburger");
		const closeBtn = document.getElementById("close-btn");
	
		// 햄버거 버튼 클릭 시 사이드바 열기
		hamburger.addEventListener("click", function () {
			sidebar.classList.add("active"); // 사이드바를 100px 위치로 이동
		});
	
		// X 버튼 클릭 시 사이드바 닫기
		closeBtn.addEventListener("click", function () {
			sidebar.classList.remove("active");
		});
});
</script>    
<!-- 에러 msg -->
<script>
	let msg = "${msg}";
	if(msg=="MOD_OK") alert("회원정보가 수정되었습니다.")
	if(msg=="JOIN_OK") alert("회원가입에 성공했습니다.");
	if(msg=="DEL_OK") alert("탈퇴되었습니다.");
</script>
</html>