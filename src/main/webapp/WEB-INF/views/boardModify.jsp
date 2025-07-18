<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    
    .backbtn {
		font-size: 40px; /* 화살표 크기 */
		color: #FF8C00; /* 화살표 색상 */
		background: none; /* 배경 제거 */
		border: none; /* 테두리 제거 */
		cursor: pointer;
		padding: 0;
		width:100px;
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
	
    .container {
        width: 900px; /* 전체 크기를 900px로 고정 */
	    display: flex;
	    flex-direction: column;
	    align-items: center;
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
	}
	
	input[type="text"] {
	    flex: 1; /* 입력 필드 크기 설정 */
	    width: 100%; /* 입력 필드의 너비를 100%로 설정 */
	    padding: 20px; /* 내부 여백 */
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    font-size: 25px; /* 폰트 크기 */
	    box-sizing: border-box;
	}
		
	textarea {
	    border: 1px solid #ccc;
	    width: 850px;
	    height: 500px;
	    border-radius: 5px;
	    padding-left: 10px;
	    padding-top: 10px;
	    resize: none;
	    font-size:30px;
	    overflow: hidden; /* 스크롤바 숨김 */
	}
	
	textarea::placeholder {
		position: absolute;
	    top: 20px; /* 상단 위치 지정 */
	    left: 20px; /* 왼쪽 위치 지정 */
	    font-size: 25px; /* 폰트 크기 placeholder와 동일하게 설정 */
	    color: #aaa; /* placeholder 색상 */
	}
	
	form {
	    width: 100%;
	    max-width: 900px; /* 폼 크기를 제한 */
	    display: flex;
	    flex-direction: column;
	    gap: 12px;
	 }
	 
	 .btn{
	 	width:100%;
	 	display:flex;
	 }
    
     .subBtn {
	  	width: 100%;
	    padding: 30px; /*내부 여백*/
	    margin-top:10px;
	    margin-bottom:10px;
	    font-size: 1rem;
	    color: #fff;
	    background-color: #FF8C00;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	    font-size: 30px;
	}	
	
	.image-upload-container {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    gap: 20px; /* 이미지 업로드 간격 */
	}
    
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
    
    .image-upload-group {
        display: flex;
	    justify-content: space-between;
	    align-items: center;
	    gap: 10px;
	    width: 100%;
	    max-width: 700px; 
    }
    
    .image-upload-label {
        display: block;
        text-align: center;
        font-weight: bold;
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
	}
	
	.preview-image {
	    width: 100%;
	    height: 100%;
	    object-fit: cover; /* 이미지 비율에 맞게 잘라서 꽉 채움 */
	    display: none; /* 기본적으로 이미지는 숨김 */
	}
	
	input[type="file"] {
	    display: none;
	}
		
    .divider {
        width: 1px;
        height: 200px;
        background-color: black;
        margin-left:50px;
        margin-right:50px;
    }
    
    .image-container img{
		width:800px;
		margin-bottom: 20px;
		border: 2px solid #ccc;
		border-radius:40px;
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
    <h2>게시물 수정</h2>
    <%@ include file="/WEB-INF/views/timeout.jsp" %>
</div>
<div class="container">
<form action="<c:url value='/board/modify'/>" method="post" id="form" onsubmit="return validateForm()" enctype="multipart/form-data">
	<input type="hidden" name="bno" value="${boardDto.bno}">
	<input type="hidden" name="img1_hidden" value="${boardDto.img1}">
	<input type="hidden" name="img2_hidden" value="${boardDto.img2}">
	<input type="hidden" name="img3_hidden" value="${boardDto.img3}">
	<div class="input-group">
		<input type="text" name="title" id="title" value="${boardDto.title}">
	</div>
	<div class="input-group">
		<textarea name="content" id="content" rows="1">${boardDto.content}</textarea>
	</div>
	<div class="image-upload-container">
	    <div class="image-upload-group">
	     	<!-- 대표 이미지 -->
	        <label class="image-upload" for="file1">
	             <input type="file" name="file1" id="file1" hidden onchange="previewImage(this, 'preview1', 'file-name1')">
	                <div class="upload-circle">
	                    <span class="plus-sign">+</span>
	                    <c:choose>
							<c:when test="${not empty boardDto.img1}">
								<img src="${data_path}/upload/${boardDto.img1}" alt="대표 이미지">
							</c:when>
							<c:otherwise>
								<img id="preview1" class="preview-image" alt="대표 이미지">
							</c:otherwise>
						</c:choose>
	                </div>
	         </label>
	         <span class="divider"></span>
	         <!-- 추가 이미지 1 -->
	         <label class="image-upload" for="file2">
	                <input type="file" name="file2" id="file2" hidden onchange="previewImage(this, 'preview2', 'file-name2')">
	                <div class="upload-circle">
	                    <span class="plus-sign">+</span>
	                    <c:choose>
							<c:when test="${not empty boardDto.img2}">
								<img src="${data_path}/upload/${boardDto.img2}" alt="추가 이미지1">
							</c:when>
							<c:otherwise>
								<img id="preview2" class="preview-image" alt="추가 이미지1">
							</c:otherwise>
						</c:choose>
	                </div>
	         </label>
	          <!-- 추가 이미지 2 -->
	          <label class="image-upload" for="file3">
	                <input type="file" name="file3" id="file3" hidden onchange="previewImage(this, 'preview3', 'file-name3')">
	                <div class="upload-circle">
	                    <span class="plus-sign">+</span>
	                    <c:choose>
							<c:when test="${not empty boardDto.img3}">
								<img src="${data_path}/upload/${boardDto.img3}" alt="추가 이미지 2">
							</c:when>
							<c:otherwise>
								<img id="preview3" class="preview-image" src="" alt="추가 이미지 2">
							</c:otherwise>
						</c:choose>	                    
	                </div>
	          </label>
	    </div>
	</div>
	<div class="btn">
		<button type="submit" class="subBtn">수정</button>
	</div>
</form>
</div>
</div>
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
<!-- 유효성 검사 -->
<script>
	function validateForm(){
		let title = $("#title").val();
		let content = $("#content").val();
		
		if(title==""&&content==""){
			alert("게시글 제목과 내용을 입력해주세요");
			return false;
		} else if(title==""){
			alert("게시글 제목을 입력해주세요");
			return false;
		} else if(content==""){
			alert("게시글 내용을 입력해주세요");
			return false;
		}
	}
</script>
<script>
  let msg = "${msg}";
  if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
<script>
//목록버튼
$(document).ready(function(){ //main()함수
	$('#listBtn').on("click", function(){
		location.href = "<c:url value='/board/list?page=${page}&pageSize=${pageSize}'/>";
	})
})
</script>
<!-- 이미지 미리보기 기능 -->
<script>
function previewImage(input, previewId) {
    var file = input.files[0];
    var reader = new FileReader();
    
    reader.onload = function(e) {
        let preview = $('#' + previewId);
        preview.attr('src', e.target.result);
        preview.show();
        preview.closest('.image-upload').find('.plus-sign').hide();
    };

    if (file) {
        reader.readAsDataURL(file);
    }
}
</script>
<!-- 수정 완료 등록 버튼 -->
</body>
</html>