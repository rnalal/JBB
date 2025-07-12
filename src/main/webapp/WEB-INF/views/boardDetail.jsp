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
		display: flex; /* 플렉스 컨테이너로 설정 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 세로 중앙 정렬 */
	    flex-direction: column; /* 컨텐츠를 세로로 배치 */
	    margin: 0; /* 기본 여백 제거 */
	    height: 100vh; /* 화면 전체 높이 사용 */
	    justify-content: flex-start;
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

    .container {
        width: 900px; /* 전체 크기를 900px로 고정 */
	    display: flex;
	    flex-direction: column;
	    padding: 16px;
	    box-sizing: border-box;
	    background-color: #ffffff;
    }
    
    .input-group {
	    display: flex;
	    flex-direction: column; /* 라벨과 입력 필드를 세로로 배치 */
	    width: 100%;
	    margin-top: 20px; /* 위쪽 여백 추가 */
	    margin-bottom: 12px; /* 아래쪽 여백 추가 */
	    texl-align:left;
	}
	
	input[type="text"] {
	    flex: 1; /* 입력 필드 크기 설정 */
	    width: 850px; 
	    padding: 10px; /* 내부 여백 */
	    font-size: 33px; /* 폰트 크기 */
	    box-sizing: border-box;
	    border:none;
	    font-weight: bold;
	}
	
	textarea {
	    width: 850px;
	    height: auto; 
        padding: 5px;
        margin-bottom: 10px; 
        resize: none; /*사용자 크기조절 제한*/
        font-size: 30px;
        border: none; /* 테두리 제거 */
        text-align: left; /* 왼쪽 정렬 */
        box-sizing: border-box; /* 패딩 포함 크기 계산 */
		overflow: hidden; /* 스크롤 숨기기 */
		line-height: 1.5; /* 줄 간격 조정 */
		white-space: pre-line; /* 변경된 줄바꿈 방식 */
		word-wrap: break-word; /* 긴 단어 줄바꿈 */
	}
	
	input:focus, textarea:focus {
	    outline: none; /* 포커스 테두리를 없앰 */
	}
	
	.image-container img{
		width:800px;
		margin-bottom: 20px;
		border: 2px solid #ccc;
		border-radius:40px;
	}

    .header {
        display: flex;
	    justify-content: space-between; /* 왼쪽에는 작성자 정보, 오른쪽에는 드롭다운 */
	    align-items: center; /* 세로 중앙 정렬 */
	    padding: 10px;
    }
    
    .user-info {
	    display: flex;
	    align-items: center;
	    gap: 20px; /* 이미지와 텍스트 사이 간격 */
	}
	
	.user-info img {
	    width: 70px;  /* 원하는 크기로 조절 */
	    height: 70px;
	    border-radius: 50%; /* 동그랗게 */
	    object-fit: cover; /* 이미지가 찌그러지지 않게 */
	}

    .header .writer {
    	text-align: left; /* 텍스트 왼쪽 정렬 */
    	color: #111;
    	font-size:30px;
    }
    
    .header .reg {
    	float:left;
    	color: #666;
    	font-size:20px;
    }

    .header .info span {
        display: block;
    }

    .stats {
        display: flex;
	    justify-content: space-between;
	    align-items: center; /* 수직 가운데 정렬 */
	    font-size: 14px;
	    color: #888;
	    margin-bottom: 20px;
    }
    
    .stats-actions {
	    display: flex;
	    justify-content: space-between; /* 왼쪽(좋아요) - 오른쪽(조회수) */
	    align-items: center; /* 수직 중앙 정렬 */
	    margin-top: 10px;
	}
    
    .stats .buttons {
	    display: flex;
	    gap: 10px; /* 버튼 간격 조정 */
	}
	
	.stats .removeBtn {
		border: 1px solid #FF8C00;
	    background-color: white;
	    color: red;
	    padding: 10px 15px;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 20px;
	}
	
	.stats .modifyBtn {
		border: none;
	    background-color: #4CAF50;
	    color: white;
	    padding: 10px 15px;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 20px;
	}

    .actions {
        display: flex;
        justify-content: space-between;
        padding-top: 15px;
    }

    .actions button {
        border: none;
        background: none;
        font-size: 20px;
        cursor: pointer;
        color: #555;
    }

    .view_cnt {
    	font-size: 20px;
	    color: #555;
    }
    
    ul{
    	list-style-type: none;
    	padding: 0; /* 기본 패딩 제거 */
		margin: 0; /* 기본 마진 제거 */
    }
    
    li {
    	height:150px;
    }
    
    .comments {
	  border-top: 1px solid #ddd;
	  margin-top: 20px;
	  padding-bottom: 100px; 
	  margin-bottom:80px;
	}
	
	.comment {
	  padding: 15px 0;
	  font-size:20px;
	}
	
	.buttons {
	    display: flex;
	    float: right;
	    gap: 10px; /* 버튼 간격 조정 */
	}
	
	.delBtn {
		border: 1px solid #FF8C00;
	    background-color: white;
	    color: #FF8C00;
	    padding: 10px 15px;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 20px;
	}
	
	.modBtn {
		border: none;
	    background-color: #FF8C00;
	    color: white;
	    padding: 10px 15px;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 20px;
	}
	
	.comment-header {
	  	display: flex;
	    align-items: center;
	    gap: 20px; /* 이미지와 텍스트 사이 간격 */
	    margin-top:50px;
	}
	
	.comment-header img {
	  width: 50px;  /* 원하는 크기로 조절 */
	  height: 50px;
	  border-radius: 50%; /* 동그랗게 */
	  object-fit: cover; /* 이미지가 찌그러지지 않게 */
	}
	
	.comment-author {
	  font-weight: bold;
	  font-size: 25px;
	}
	
	.comment-date {
	  font-size: 20px;
	  color: #888;
	}
	
	.comment-text {
	  width: 100%;
	  border:none;
	  font-size: 25px;
	  color: #333;
	  height: auto;
	  overflow: hidden; /* 스크롤바 숨김 */
	  resize: none; /* 사용자가 크기 조절 못하게 함 */
	  word-break: break-word; /* 긴 단어가 있을 경우 강제 줄바꿈 */
	  white-space: pre-wrap; /* 줄 바꿈 유지 + 자동 줄바꿈 적용 */
	}
	
	.add-comment {
	  display: flex;
	  justify-content: space-between;
	  margin-top: 10px;
	  padding: 10px;
	  bottom: 0;
	  width: 964px;
	  position: fixed;
	  background-color: white;
	  left: 50%; /* 화면의 가운데로 이동 */
	  transform: translateX(-50%); /* 가운데로 정확히 위치시킴 */
	}
	
	.add-comment input {
	  padding: 20px;
	  color: #757575;
	  border: 2px solid #BDBDBD;
	  border-radius: 30px;
	}
		
	.add-comment button {
	  width: 18%;
	  padding: 20px;
	  background-color: #FF8C00;
	  color: white;
	  border: none;
	  border-radius: 30px;
	  cursor: pointer;
	  font-size: 20px;
	}
	
	.cmt_size {
		font-size:30px;
		font-weight: bold;
	}
		
	.heart {
	    font-size: 30px;  /* 하트 크기 조절 */
	}
	
	.likeCount {
	    font-size: 25px;
	    font-weight: bold;
	    margin-left: 5px;
	    color:black;
	}
	
	.like-btn {
	    display: flex;
	    align-items: center;
	    font-size: 20px;
	    background: none;
	    border: none;
	    cursor: pointer;
	    color: #FF4500; /* 좋아요 버튼 색상 */
	}
	
	/* 드롭다운 버튼 스타일 */		
	.dropdown-container {
	    position: relative;
	}	
	/* ⋮ 버튼 스타일 */
	.dropdown-btn {
	    background: none;
	    border: none;
	    font-size: 40px;
	    cursor: pointer;
	    color: #888;
	}	
	/* 드롭다운 메뉴 */
	.dropdown-menu {
	    position: absolute;
	    right: 0;
	    top: 30px;
	    background: white;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    display: none;
	    width: 150px;
	    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
	    list-style: none;
	    padding: 5px 0;
	}	
	.dropdown-menu li {
	    text-align: center;
	    height:50px;
	    padding: 10px;
	}	
	.dropdown-menu li button {
	    background: none;
	    border: none;
	    cursor: pointer;
	    font-size: 20px;
	    width: 100%;
	    padding: 10px;
	    font-weight: bold;
	}	
	
	.removeBtn{
		color:#FF8C00;
	}
	
	/* 등록 버튼 */
	.register-btn {
	    background: #FF8C00;
	    color: white;
	    border: none;
	    padding: 5px 10px;
	    font-size: 20px;
	    border-radius: 5px;
	    cursor: pointer;
	}	
	
	#commentCount {
		font-size:30px;
	}
	
	/*수정-이미지 업로드*/
	.image-upload {
        display: flex;
	    justify-content: center;
	    align-items: center;
	    width: 200px; /* 정사각형 크기 */
	    height: 200px;
	    background-color: #ccc;
	    border-radius: 8px;
	    position: relative;
	    overflow: hidden; /* 이미지가 버튼 영역을 벗어나지 않도록 */
	    cursor: pointer; 
    }
    
    .edit-images{
    	display:flex;
    	flex-direction: column;
	    align-items: center;
	    gap: 20px; /* 이미지 업로드 간격 */
    }
    
    .image-upload-group {
        display: flex;
	    justify-content: space-between;
	    align-items: center;
	    gap: 10px;
	    width: 100%;
	    max-width: 700px; 
    }
    
    .upload-circle {
        display: flex;
	    justify-content: center;
	    align-items: center;
	    width: 100%;
	    height: 100%;
	    position: relative;
    }
    .plus-sign {
	    font-size: 40px;
	    color: white;
	    display: block;
	    position: absolute;
	    z-index: 1;
	}
	.preview-image {
	    width: 100%;
	    height: 100%;
	    object-fit: cover; /* 이미지 비율에 맞게 잘라서 꽉 채움 */
	    display: none; /* 기본적으로 이미지는 숨김 */
	    position: absolute;
    	z-index: 2;
	}	
	.divider {
        width: 1px;
        height: 200px;
        background-color: black;
        margin-left:50px;
        margin-right:50px;
    }
    .img_letter{
    	margin-top:30px;
    	margin-bottom:20px;
    	font-size:30px;
    	font-weight:bold;
    }
</style>
</head>
<body>
<div class="body">
<div class="jbb-title">
	<div class="title-left">
	    <button type="button" class="backbtn" onclick="history.back()"><</button>
	    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
	    <div class="title-right">
		    <%@ include file="/WEB-INF/views/common_notification.jsp" %>
		 </div>
    </div>
    <h2>게시물</h2>
    <%@ include file="/WEB-INF/views/timeout.jsp" %>
</div>
<div class="container">
	<div class="header">
		<div class="user-info">
			<img src="${data_path }/img/user_default.png" alt="User">
			<div class="info">
		       <span class="writer"><c:out value="${boardDto.writer}"/></span>
		       <span class="reg"><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy.MM.dd"/></span>
		    </div>
		</div>    
	    <c:if test="${sessionScope.id eq boardDto.writer}">
	        <!-- 수정/삭제 드롭다운 버튼 -->
	        <div class="dropdown-container">
	            <button class="dropdown-btn">⋮</button>
	            <ul class="dropdown-menu">
	                <li><button type="button" id="modifyBtn" class="modifyBtn">수정</button></li><hr>
	                <li><button type="button" id="removeBtn" class="removeBtn">삭제</button></li>
	            </ul>
	        </div>
	    </c:if>
	</div>  
	<form id="form" enctype="multipart/form-data">
<%-- 	<p style="font-size:14px; color:red;">
		  본 글 목록: ${sessionScope.viewedPosts}
		</p> --%>
	 	<input type="hidden" name="bno" value="${boardDto.bno}">
	 	<input type="hidden" name="cno" value="${commentDto.cno}">
	 	<input type="hidden" name="page" value="${page}">
	 	<input type="hidden" name="pageSize" value="${pageSize}">
	 	<div class="input-group">
			<input type="text" name="title" class="editable" value="<c:out value='${boardDto.title}'/>" readonly="readonly">
		</div>
		<div class="input-group">
			<textarea name="content" id="content" class="editable" readonly="readonly">
				<c:out value="${boardDto.content}"/>				
			</textarea>
		</div>
		<div class="image-container">
			<!-- img1 -->
			<c:choose>
				<c:when test="${not empty boardDto.img1}">
					<img src="${data_path}/upload/${boardDto.img1}" alt="대표 이미지">
				</c:when>
				<c:otherwise>
					<img src="${data_path}/img/default_img.png" alt="기본 이미지">
				</c:otherwise>
			</c:choose>		
			<!-- img2 -->
			<c:choose>
				<c:when test="${not empty boardDto.img2}">
					<img src="${data_path}/upload/${boardDto.img2}" alt="이미지 2">
				</c:when>
				<c:otherwise>
					<!-- 필요하면 기본 이미지 넣고, 아니면 생략 -->
				</c:otherwise>
			</c:choose>		
			<!-- img3 -->
			<c:choose>
				<c:when test="${not empty boardDto.img3}">
					<img src="${data_path}/upload/${boardDto.img3}" alt="이미지 3">
				</c:when>
				<c:otherwise>
					<!-- 필요하면 기본 이미지 넣고, 아니면 생략 -->
				</c:otherwise>
			</c:choose>
		</div>
		<!-- 수정 모드에서 보일 이미지 업로드 영역 (초기에는 숨김) -->
		<div id="edit-images" class="edit-images" style="display: none;">
		<span class="img_letter">이미지 수정</span>
		    <div class="image-upload-group">
			    <!-- 기존 이미지 경로 유지용 hidden 필드 추가 -->
	            <input type="hidden" name="img1_hidden" value="${boardDto.img1}">
	            <input type="hidden" name="img2_hidden" value="${boardDto.img2}">
	            <input type="hidden" name="img3_hidden" value="${boardDto.img3}">
	            
			    <label class="image-upload">
			        <input type="file" name="file1" id="file1" hidden onchange="previewImage(this, 'preview1')">
			        <div class="upload-circle">
			            <span class="plus-sign">+</span>
			            <c:if test="${not empty boardDto.img1}">
						    <img id="preview1" class="preview-image" src="${data_path}/upload/${boardDto.img1}" style="display: block;" alt="대표 이미지">
						</c:if>
						<c:if test="${empty boardDto.img1}">
						    <img id="preview1" class="preview-image" style="display: none;" alt="대표 이미지">
						</c:if>
			        </div>
			    </label>
			    <span class="divider"></span>
			    <label class="image-upload">
			        <input type="file" name="file2" id="file2" hidden onchange="previewImage(this, 'preview2')">
			        <div class="upload-circle">
			            <span class="plus-sign">+</span>
			            <c:if test="${not empty boardDto.img2}">
						    <img id="preview1" class="preview-image" src="${data_path}/upload/${boardDto.img2}" style="display: block;" alt="추가 이미지">
						</c:if>
						<c:if test="${empty boardDto.img2}">
						    <img id="preview1" class="preview-image" style="display: none;" alt="추가 이미지">
						</c:if>
			        </div>
			    </label>		
			    <label class="image-upload">
			        <input type="file" name="file3" id="file3" hidden onchange="previewImage(this, 'preview3')">
			        <div class="upload-circle">
			            <span class="plus-sign">+</span>
			            <c:if test="${not empty boardDto.img3}">
						    <img id="preview1" class="preview-image" src="${data_path}/upload/${boardDto.img3}" style="display: block;" alt="추가 이미지">
						</c:if>
						<c:if test="${empty boardDto.img3}">
						    <img id="preview1" class="preview-image" style="display: none;" alt="추가 이미지">
						</c:if>
			        </div>
			    </label>
		    </div>
		</div>
	</form>	
    <div class="stats-actions">
	    <button class="like-btn" data-board-bno="${boardDto.bno}"><span class="likeCount">${likeCount }</span></button>
	    <div class="view_cnt">조회 ${boardDto.view_cnt}</div>
	</div>
	<div class="comment-section">
		<div class="comments">
		<div class="comment">
		    <p class="cmt_size">댓글 <span id="commentCount">${boardDto.comment_cnt}</span></p>
		    <div id="commentList"></div>    
		</div>
		</div>
		<c:if test="${not empty sessionScope.id}">
			<div class="add-comment">
				<input type="text" name="comment" placeholder="${id}(으)로 댓글 남기기" >
				<button id="sendBtn" type="button">댓글등록</button>
			</div>
		</c:if>
	</div>
</div>
</div>
<!-- textarea 크기 자동 조절 -->
<script>
$(window).on("load resize", function () {
    setTimeout(adjustTextareaHeight, 100); // 100ms 딜레이 후 실행
});
// 이미지가 로드될 때도 여백 조정
$(".image-container img").on("load", function () {
    setTimeout(adjustTextareaHeight, 50);
});

function adjustTextareaHeight() {
    let $textarea = $(".input-group textarea");
    $textarea.css("height", "auto"); // 초기화
    $textarea.css("height", ($textarea.prop("scrollHeight") + "px")); // 내용에 맞게 조절

    let $imageContainer = $(".image-container");

    if ($imageContainer.length > 0) {
        let textareaBottom = $textarea.offset().top + $textarea.outerHeight();
        let imageContainerTop = $imageContainer.offset()?.top;

        if (imageContainerTop !== undefined) {
            let gap = imageContainerTop - textareaBottom;

            if (gap !== 20) {
                let newMargin = 20 - gap;
                if (newMargin < 0) newMargin = 0; // 음수 방지
                $textarea.css("margin-bottom", `${newMargin}px`);
            }
        }
    }
}
</script>
<!-- 헤더메뉴 -->
<script>
$(document).ready(function () {
    $(".dropdown-btn").click(function (event) {
        event.stopPropagation(); // 이벤트 전파 방지
        $(".dropdown-menu").not($(this).next()).hide(); // 다른 메뉴 닫기
        $(this).next(".dropdown-menu").toggle(); // 현재 메뉴 열기/닫기
    });

    // 다른 곳 클릭하면 드롭다운 닫기
    $(document).click(function () {
        $(".dropdown-menu").hide();
    });

    // 드롭다운 메뉴 클릭 시 닫히지 않도록 방지
    $(".dropdown-menu").click(function (event) {
        event.stopPropagation();
    });
});
</script>
<!-- 좋아요 -->
<script>
$(document).ready(function () {
    let boardBno = "${boardDto.bno}";
    let contextPath = "${pageContext.request.contextPath}";
    let $likeButton = $(".like-btn");

    // 좋아요 상태 및 개수 가져오기
    $.ajax({
        type: "GET",
        url: contextPath + "/likes/isLiked/" + boardBno, // 컨트롤러의 변경된 API URL 사용
        success: function (response) {
            if (response.error) {
                console.error(response.error);
                return;
            }
            updateLikeButton(response.isLiked, response.likeCount);
        },
        error: function () {
            console.error("좋아요 상태 및 개수 가져오기 실패");
        }
    });

    // 좋아요 버튼 클릭 이벤트
    $likeButton.click(function () {
        let userId = "<c:out value='${sessionScope.id}'/>";
        if (!userId) {
            alert("로그인이 필요합니다!");
            return;
        }

        $.ajax({
            type: "POST",
            url: contextPath + "/likes",
            contentType: "application/json",
            data: JSON.stringify({ user_id: userId, board_bno: boardBno }),
            success: function (response) {
                if (response.error) {
                    alert("오류 발생");
                    return;
                }
                updateLikeButton(response.liked, response.likeCount);
            },
            error: function () {
                console.error("좋아요 요청 실패");
            }
        });
    });

    // 좋아요 버튼 UI 업데이트 함수
    function updateLikeButton(isLiked, likeCount) {
        if (isLiked) {
            $likeButton.html("<span class='heart'>❤️</span><span class='likeCount'>" + likeCount + "</span>");
        } else {
            $likeButton.html("<span class='heart'>🤍</span><span class='likeCount'>" + likeCount + "</span>");
        }
    }
});
</script>
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
<!-- 메세지출력 -->
<script>
	let msg = "${msg}";
	if(msg=="DEL_ERR") alert("삭제에 실패했습니다.");
</script>
<!-- 댓글 -->
<script>	
	let loggedInUser = "<c:out value='${sessionScope.id}'/>";
    let bno = $("input[name='bno']").val();
    let cno = $("input[name='cno']").val();
    	
    	let showList = function(bno){
    		$.ajax({
                type:'GET',       // 요청 메서드
                url: '/jbb/comments?bno='+bno,  // 요청 URI
                success : function(result){
                   $("#commentList").html(toHtml(result));	//서버로부터 응답이 도착하면 호출될 함수
                },
                error : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); 
    	}
    	
        $(document).ready(function(){
        	showList(bno);
        	
        	//댓글등록
            $("#sendBtn").click(function(){
               let comment = $("input[name=comment]").val();
               
               /* 댓글 공백 입력 금지 */
               if(comment.trim()==''){
            	   alert("댓글을 입력해주세요.");
            	   $("input[name=comment]").focus()
            	   return;
               }
               
               $.ajax({
            	   type:'POST',
            	   url: '/jbb/comments?bno='+bno,
            	   headers : { "content-type": "application/json"},
            	   data : JSON.stringify({bno:bno, comment:comment}),
            	   success : function(result){
            		   alert("댓글이 등록되었습니다.");
                       $("input[name=comment]").val(''); // 댓글 입력창 비우기
            		   showList(bno); //댓글 목록 새로고침
            	   },
               	   error : function(){ alert("댓글 등록 중 오류 발생") } // 에러가 발생했을 때, 호출될 함수
               });               
            });
            
            //댓글수정
            $("#commentList").on("click", ".modBtn",function(){
            	let li = $(this).closest("li"); 
                let cno = li.attr("data-cno");  
                let inputField = li.find(".comment-text");
                let modBtn = $(this);
                
             	// 현재 readonly 상태인지 확인
                let isReadonly = inputField.prop("readonly");

                if(isReadonly){
                	// readonly 해제 → 수정 가능하게 변경
                    inputField.prop("readonly", false);
                    modBtn.text("등록"); // 버튼 텍스트 변경
                    inputField.css({
                    	"width": "700px",
                    	"height": "50px",
                        "border": "1px solid #ccc",
                        "background-color": "#f9f9f9",
                        "border-radius": "4px" /* 둥근 모서리 */
                    });
                } else {
                    // 수정된 댓글 서버로 전송
                    let updatedComment = inputField.val(); // 수정된 댓글 가져오기

                    $.ajax({
                        type: "PATCH",
                        url: "/jbb/comments/" + cno,  // 경로 확인 필요
                        headers: { "content-type": "application/json" },
                        data: JSON.stringify({ cno: cno, comment: updatedComment }),
                        success: function (result) {
                            alert("댓글이 수정되었습니다.");
                            showList(bno); // 댓글 목록 새로고침
                        },
                        error: function () {
                            alert("댓글 수정 중 오류 발생");
                        },
                    });
                }
            });
            
            //댓글삭제
            $("#commentList").on("click", ".delBtn",function(){
            	let li = $(this).closest("li");  // 삭제 버튼이 포함된 li 요소 찾기
                let cno = li.attr("data-cno");  // cno 값 가져오기
                let bno = li.attr("data-bno");  // bno 값 가져오기

     		    // 삭제 확인 창 추가
     		    if (!confirm("댓글을 삭제하시겠습니까?")) {
     		        return; // 사용자가 취소하면 삭제 중단
     		    }
     			
            	$.ajax({
                    type:'DELETE',       // 요청 메서드
                    url: '/jbb/comments/'+cno+'?bno='+bno, // 요청 URI
                    success : function(result){
                    	alert("댓글이 삭제되었습니다.");
                    	showList(bno);
                    },
                    error   : function(){ alert("댓글 삭제 중 오류 발생") } // 에러가 발생했을 때, 호출될 함수
                });
            });
        });
        
        //formatDate(dateString) 함수를 추가 → comment.up_date 값을 받아서 yyyy.MM.dd 형식으로 변환
        let formatDate = function(dateString) {
        	let date = new Date(dateString);
            let year = date.getFullYear();
            let month = String(date.getMonth() + 1).padStart(2, '0');
            let day = String(date.getDate()).padStart(2, '0');

            return year + '.' + month + '.' + day;
        };
        
        let toHtml = function(comments){
        	let tmp = "<ul>";
        		
        	comments.forEach(function(comment){
        		tmp += '<li data-cno='+ comment.cno
        		tmp += ' data-pcno=' + comment.pcno
        		tmp += ' data-bno=' + comment.bno + '>'
        		tmp += '<div class="comment-header">'
        		tmp += '<img src="${data_path }/img/user_default.png" alt="User">'
        		tmp += '<p class="comment-author">' + comment.commenter + '</p>'
        	    tmp += '<p class="comment-date">' + formatDate(comment.up_date)  + '</p>'
        	    tmp += '</div>'
        	    tmp += '<textarea class="comment-text" readonly>' + comment.comment + '</textarea>';
        	    
        	    // 로그인한 사용자가 댓글 작성자와 같으면 삭제,수정 버튼 추가
        	    if (comment.commenter === loggedInUser) {
 					tmp += '<div class="buttons">'       	                        
                    tmp += '<button class="modBtn">수정</button>';
                    tmp += '<button class="delBtn">삭제</button>';
 					tmp += '</div>' 
 				
                }
        	    
        		tmp += '</li>'
        	})	
        	
        	return tmp + "</ul>";
        }
</script>
<script>
//수정버튼
$('#modifyBtn').on("click", function(){
	let form = $('#form');
	form.attr("action", "<c:url value='/board/modify'/>");
	form.attr("method", "get");
	form.submit();
})
//삭제버튼
$('#removeBtn').on("click", function(){
	if(!confirm("정말로 삭제하시겠습니까?")) return;
	let form = $('#form');
	form.attr("action", "<c:url value='/board/remove?page=${page}&pageSize=${pageSize}'/>");
	form.attr("method", "post");
	form.submit();
})
</script>
</body>
</html>