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
		
    .grid-container {
    	width: 900px;
    	display: flex; /* 플렉스박스 사용 */
		flex-direction: column; /* 세로 정렬 */
		align-items: flex-start; /* 왼쪽 정렬 (기본값이므로 생략 가능) */
		padding: 16px; /* 내부 여백 */
		margin: 20px auto 16px; /* 위쪽 공백 20px, 좌우 가운데 정렬, 아래쪽 공백 16px */
    }
    
    .board-item {
	    display: flex;
	    align-items: center;
	    padding: 10px;
	}
    
    .board-title, .board-content {
    	white-space: nowrap; /*한 줄로 표시*/
    	overflow: hidden; /*넘치는 텍스트 숨김*/
    	text-overflow: ellipsis; /*말줄임표 표시*/
    	display: block; /*블록 요소로 설정*/
    }
    
    .board-title {
      text-decoration: none;
	  font-size: 35px; 
	  font-weight: bold; 
	  margin: 0; /* 기본 여백 제거 */
	  color: #333; 
	}
	
	.board-content {
	  font-size: 25px; /* 내용 글자 크기 */
	  color: #696969; /* 내용 글자 색 */
	  margin: 0; /* 기본 여백 제거 */
	}
	
	.board-bottom {
		display: flex;
		gap: 0; /* 요소 사이 기본 간격 제거 */
		align-items: center; /* 수직 중앙 정렬 */
		font-size:20px;
	}
	
	.main_img {
	    margin-right: 50px; /* 이미지와 텍스트 간격 */
	}
	
	.main_img img {
		width:300px;
		height:300px;
		border: 2px solid #ccc;
		border-radius:10px;
	}
	
	.board-content-wrapper {
	    flex: 1; /* 남은 공간 차지 */
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    text-align: left; /* 왼쪽 정렬 */
	    gap: 20px; /* 제목, 내용, bottom 간 여백 추가 */
	}
	
	.b-b {
		display: flex; /* 내부 텍스트와 점도 플렉스 컨테이너로 설정 */
		align-items: center; /* 수직 중앙 정렬 */
  		margin: 0;
   		padding: 0;
	}
	
	/*열거된 글자 사이에 점 넣기*/	
	.b-b::after {
	  content: "·"; /* 점 표시 */
	  margin: 0 5px; /* 점과 텍스트 간격 설정 */
	}	
	/*마지막 글자 뒤에는 X*/	
	.b-b:last-child::after {
	  content: ""; /* 마지막 요소 뒤에는 점 제거 */
	}
    
    button.writebtn {
	    position: fixed; /* 고정 위치 */
	    bottom: 2vh; /* 화면 하단에서 2% 위치 */
	    right: 2vw; /* 화면 오른쪽에서 2% 위치 */
	    background-color: #FF8C00; /* 버튼 배경색 */
	    color: white;
	    padding: 10px 20px; /* 내부 여백 */
	    border: none;
	    border-radius: 50px; /* 둥근 모서리 */
	    font-size: 30px;
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
	    cursor: pointer;
	    z-index: 1000; /* 항상 위에 표시 */
	    transition: all 0.3s ease-in-out; /* 크기/위치 전환 효과 */
	}
	
	@media (max-width: 768px) {
	    /* 작은 화면용 */
	    button.writebtn {
	        bottom: 3vh; /* 더 높은 위치 */
	        right: 3vw; /* 버튼이 화면에 더 가까이 */
	        font-size: 14px; /* 버튼 크기 줄이기 */
	        padding: 8px 16px;
	    }
	}
	
	@media (max-width: 480px) {
	    /* 아주 작은 화면용 (예: 스마트폰) */
	    button.writebtn {
	        bottom: 4vh;
	        right: 4vw;
	        font-size: 12px;
	        padding: 6px 12px;
	    }
	}	
	
	hr {
  		border: none; /* 기존 테두리 제거 */
  		border-top: 1px solid #ccc; /* 회색 선 스타일 */
  		margin: 20px 0; /* 상하 여백 */
 		width: 100%; /* 선이 전체 너비로 표시되도록 */
	}
	
	.paging {
	    display: flex; /* 플렉스 레이아웃 */
	    justify-content: center; /* 가로 중앙 정렬 */
	    align-items: center; /* 수직 중앙 정렬 */
	    gap: 10px; /* 숫자 간 간격 */
	    margin: 20px auto 0; /* 페이지 맨 아래 중앙에 위치하도록 여백 설정 */
	}
		
	.paging a {
		text-decoration: none; /* 밑줄 제거 */
	    font-size: 35px; /* 글자 크기 */
	    color: #333; /* 글자 색상 */
	    padding: 5px 10px; /* 숫자 버튼 안쪽 여백 */
	    border-radius: 4px; /* 둥근 테두리 */
	    transition: background-color 0.3s ease; /* 호버 효과 */
	}
	
	.paging a:hover {
	    background-color: #f0f0f0; /* 호버 시 배경색 */
	}
	 
	.paging a.paging-active {
	    background-color: #f0f0f0; /* 현재 페이지 배경색 */
	    color: #333; /* 글자 색 */
	    border-radius: 20%; /* 동그라미 */
	    padding: 5px 10px; /* 숫자 버튼 안쪽 여백 */
	    border: 1px solid #ccc; /* 테두리 */
	    font-weight: bold; /* 강조 */
	}
	
	.paging a.paging-active:hover {
	    background-color: #e0e0e0; /* 호버 시 더 짙은 회색 */
	}
	
	.search-container {
      width: 100%;
      height: 110px;
      margin-top : 10px;
      margin-bottom: 30px;
      border: none;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    
    .search-form {
      height: 45px;
      display: flex;
    }
    
    .search-option {
      width: 200px;
      height: 55px;
      outline: none;
      margin-right: 5px;
      border: 1px solid #ccc;
      color: gray;
      font-size: 25px;
    }

    .search-option > option {
      text-align: center;
    }

    .search-input {
      color: gray;
      background-color: #E0E0E0;
      border: none;
      height: 100%;
      width: 600px;
      font-size: 25px;
      padding: 5px 7px;
    }
    
    .search-input placeholder {
    	color:#D3D3D3;
    }

    .search-button {
      border:none;
      width: 20%;
      height: 55px;
      background-color: #FF8C00;
      color: white;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 30px;
    }   
    
    .category-buttons {
    	margin-bottom: 20px;
	}
	
	.main-category-button {
	    padding: 10px 20px;
	    margin: 5px;
	    cursor: pointer;
	    background-color: #f0f0f0;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    font-size: 20px;
	}
	
	.category-button {
	    padding: 10px 20px;
	    margin: 5px;
	    cursor: pointer;
	    background-color: #f0f0f0;
	    border: 1px solid #ddd;
	    border-radius: 5px;
	    font-size: 20px;
	}
	
	.category-button:hover {
	    background-color: #e0e0e0;
	}
	
	#sub-category-container {
	    display: none; /* 대분류 선택 후에만 나타남 */
	}
	
	.category-label {
		width:90px;
	    background-color: #FF8C00; /* 배경색 */
	    color: white; /* 글자색 */
	    font-size: 20px;
	    padding: 5px 12px;
	    border-radius: 12px; /* 모서리 둥글게 */
	    text-align:center;
	} 
	
	.nolist{
		font-size: 30px;
		margin-top:150px;
		width: 932px;
		text-align:center;
		color:#FF8C00;
		font-weight:bold;
	} 
	
</style>
<body>
<c:if test="${not empty alertMsg}">
	<script type="text/javascript">
		alert("${fn:escapeXml(alertMsg)}");
	</script>
</c:if>
<div class="container">
<div class="jbb-title">
	<div class="title-left">
	    <button type="button" class="backbtn" onclick="history.back()"><</button>
	    <img id="home-icon" class="home-icon" src="${data_path}/img/home.png" alt="홈">
	    <div class="title-right">
		    <%@ include file="/WEB-INF/views/common_notification.jsp" %>
		 </div>
    </div>
	<h2>커뮤니티</h2>
	<%@ include file="/WEB-INF/views/timeout.jsp" %>
</div>
<!-- 검색 기능 -->
<div class="search-container">
      <form action="<c:url value="/board/list"/>" class="search-form" method="get">
        <select class="search-option" name="option">
          <option class="option" value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
          <option class="option" value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
          <option class="option" value="W" ${ph.sc.option=='W' ? "selected" : ""}>작성자</option>
        </select>
        <input type="text" name="keyword" class="search-input" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
        <input type="submit" class="search-button" value="검색">
      </form>
</div>
<!-- 대분류 버튼 -->
<div class="category-buttons">
    <div id="mainCategory">
        <button class="main-category-button" id="allCategoryBtn" data-category-id="" disabled>전체글보기</button>
        <c:forEach var="category" items="${categories}">
            <c:if test="${category.bc_code_ref_mn == null}">
                <button class="main-category-button" data-category-id="${category.bc_code}">
                    ${category.bc_name}
                </button>
            </c:if>
        </c:forEach>
    </div>
</div>  
<!-- 중분류 버튼들 (대분류 선택 후 나타남) -->
<div class="category-buttons">
    <div id="sub-category-container">
        <!-- 중분류 버튼들은 여기서 동적으로 로드됨 -->
    </div> 
</div>
<!-- 게시글 목록 -->
<div id="boardListContainer" class="grid-container">
	<c:forEach var="boardDto" items="${list}">
		<div class="board-item">
			<!-- 왼쪽 이미지 -->
			<div class="main_img">
				<c:choose>
					<c:when test="${not empty boardDto.img1}">
						<img src="${data_path}/upload/${boardDto.img1}" alt="대표 이미지">
					</c:when>
					<c:otherwise>
						<img src="${data_path}/img/default_img.png" alt="기본 이미지">
					</c:otherwise>
				</c:choose> 
			</div>
			<!-- 오른쪽 텍스트 영역 -->	
			<div class="board-content-wrapper">
				<span class="category-label">${boardDto.bc_name}</span>
				<a href="<c:url value="/board/read${ph.sc.queryString}&bno=${boardDto.bno}"/>" class="board-title">
				<c:choose>
					<c:when test="${fn:length(boardDto.title) > 20}">
						${fn:substring(boardDto.title, 0, 20)}...
					</c:when>	
					<c:otherwise>
						${boardDto.title}
					</c:otherwise>
				</c:choose>
				</a><br> 
				<p class="board-content">
					<c:choose>
						<c:when test="${fn:length(boardDto.content) > 25}">
							${fn:substring(boardDto.content, 0, 25)}...
						</c:when>
						<c:otherwise>
							${boardDto.content}
						</c:otherwise>	
					</c:choose>
				</p><br>
				<div class="board-bottom">
					<p class="b-b"><fmt:formatDate pattern = "yyyy. M. dd" value="${boardDto.reg_date}"/></p>
					<p class="b-b">조회 ${boardDto.view_cnt }</p>
					<p class="b-b">댓글 ${boardDto.comment_cnt }</p>
				</div>
			</div>
		</div>
		<hr>
	</c:forEach>
</div>	
	<!-- 페이징 처리 -->
	<div class="paging">
		<c:if test="${totalCnt==null || totalCnt==0}">
          <div class="nolist"> 해당하는 게시물이 없습니다. </div>
        </c:if>
        <c:if test="${totalCnt!=null && totalCnt!=0}">
          <c:if test="${ph.showPrev}">
            <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
          </c:if>
          <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
            <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>
          </c:forEach>
          <c:if test="${ph.showNext}">
            <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
          </c:if>
        </c:if>
	</div>
</div>
<!-- 글쓰기 버튼 -->
<button type="button" class="writebtn "id="writeBtn" onclick="location.href='<c:url value="/board/write"/>'">+ 글쓰기</button>
<script>
$(document).ready(function () {
    // 전체글보기 버튼 클릭 시 화면 새로고침
    $("#allCategoryBtn").click(function () {
        location.reload();  // 페이지 새로고침
    });
});
</script>
<script>
	$(document).ready(function () {
	    // 대분류 버튼 클릭 시
	    $(".main-category-button[data-category-id]").click(function () {
	        let mainCategory = $(this).data("category-id");  // 선택한 대분류 ID
	        let contextPath = "${pageContext.request.contextPath}";

	        // 대분류 버튼을 클릭했을 때, 해당 버튼의 활성화 상태 변경
	        $(".main-category-button").prop("disabled", false);  // 모든 버튼 활성화
	        $(this).prop("disabled", true);  // 현재 선택된 대분류 버튼 비활성화

 	        // 중분류 초기화
	         $("#sub-category-container").html('').hide();  // 기존 중분류 버튼 삭제 + 숨기기 

	        if (mainCategory) {
	            // 대분류에 해당하는 중분류 버튼 로드
	            $.ajax({
	                url: contextPath + "/board/getSubCategories",
	                type: "GET",
	                data: { mainCategory: mainCategory },
	                success: function (data) {
	                	console.log("Received Data: ", data);  // 응답 데이터 확인
	                    // 받은 중분류 데이터로 버튼 추가
				            $(data).each(function (index, item) {
				            	 console.log(item.bc_code);  // 이 값이 정상적으로 찍히는지 확인
				                $("#sub-category-container").append(
				                    '<button class="category-button" data-category-id="' + item.bc_code + '">' + item.bc_name + '</button>'
				                );
				                console.log("Added button:", item.bc_name); // 버튼이 추가되는지 확인
				            });
				         // 중분류 버튼을 표시
	                     $("#sub-category-container").show();
	            	},
	                error: function (xhr, status, error) {
	                	alert("중분류 불러오기 실패!");
	                }
	            });
	        }
	    });
});
</script>

<script>
$(document).on("click", ".category-button", function () {
    let subCategory = $(this).data("category-id");  // 선택한 중분류 ID
    let contextPath = "${pageContext.request.contextPath}";
    var ph = {
        sc: {
            queryString: "${ph.sc.queryString}" // 이 값이 서버에서 전달된 ph.sc.queryString을 포함해야 합니다.
        }
    };
    
    // 모든 중분류 버튼 활성화 후, 선택한 버튼만 비활성화
    $(".category-button").prop("disabled", false);
    $(this).prop("disabled", true);

    // 게시글 목록 Ajax 요청
    $.ajax({
        url: contextPath + "/board/getPostsByCategory",
        type: "GET",
        data: { subCategory: subCategory },
        success: function (data) {
        	console.log("Received Posts Data: ", data);  // 서버에서 받은 데이터 확인
            let boardListContainer = $(".grid-container");
            boardListContainer.html(""); // 기존 게시글 목록 초기화
            
         	// 페이징 숨기기
            $(".paging").hide();

            if (data.length === 0) {
                boardListContainer.append("<div class='nolist'>게시물이 없습니다.</div>");
            } else {
                // 게시글 추가
                $(data).each(function (index, item) {
 			
                	let title = item.title ? (item.title.length > 20 ? item.title.substring(0, 20) + "..." : item.title) : "제목 없음";
                	let content = item.content ? (item.content.length > 25 ? item.content.substring(0, 25) + "..." : item.content) : "내용 없음";
                	let regDate = item.reg_date ? new Date(item.reg_date).toLocaleDateString('ko-KR') : "-";
                	let viewCnt = item.view_cnt ? item.view_cnt : "0";
                	let commentCnt = item.comment_cnt ? item.comment_cnt : "0";
                	let imgSrc = item.img1 ? contextPath + "/resources/upload/" + item.img1 : contextPath + "/resources/img/rainbow.jpg"; 
                    
                    if (item.bno) {
                    	let postHtml = '';
                    	postHtml += '<div class="board-item">';
                    	postHtml += '<div class="main_img">';
                    	postHtml += '<img src="' + imgSrc + '" alt="게시글 이미지">';
                    	postHtml += '</div>';
                    	postHtml += '<div class="board-content-wrapper">';
                    	postHtml += '<span class="category-label">' + item.bc_name + '</span>';
                        postHtml += '<a href="' + contextPath + '/board/read${ph.sc.queryString}&bno=' + item.bno + '" class="board-title">';
                        postHtml += title;
                        postHtml += '</a><br>';
                        postHtml += '<p class="board-content">' + content + '</p><br>';
                        postHtml += '<div class="board-bottom">';
                        postHtml += '<p class="b-b">' + regDate + '</p>'; 
                        postHtml += '<p class="b-b">조회 ' + viewCnt + '</p>';
                        postHtml += '<p class="b-b">댓글 ' + commentCnt + '</p>';
                        postHtml += '</div>';
                        postHtml += '</div>';
                        postHtml += '</div>';
                        postHtml += '<hr>';                       
                        boardListContainer.append(postHtml);
                    } else {
                        console.error("item.bno is empty or undefined");
                    }
                });
            }
        },
        error: function () {
            alert("게시글을 불러오는 데 실패했습니다.");
        }
    });
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
<script>
  let msg = "${msg}";
  if(msg=="WRT_OK") alert("게시물이 등록되었습니다.");
  if(msg=="DEL_OK") alert("게시물이 성공적으로 삭제되었습니다.");
  if(msg=="MOD_OK") alert("게시물이 수정되었습니다.");
  if(msg=="MOD_ERR") alert("수정에 실패했습니다.");
</script>
</body>
</html>