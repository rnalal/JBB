<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	.session-wrapper {
	    position: fixed;
	    top: 10px;
	    right: 20px;
	    z-index: 999;
	}
	
	#session-container {
	    display: flex;
	    align-items: center;
	    gap: 10px;
	    background-color: #5a5a5a;
	    color: white;
	    font-size: 20px;
	    border: none;
	    padding: 10px;
	    border-radius: 8px;
	}
	
	#extend-session-btn {
	    display: none;
	    background-color: #FF8C00;
	    color: white;
	    border: none;
	    padding: 6px 10px;
	    font-size: 20px;
	    border-radius: 5px;
	    cursor: pointer;
	}
	
	#extend-session-btn:hover {
	    background-color: #45a049;
	}
</style>
</head>
<body>
<div class="session-wrapper">
    <div id="session-container">
        <button id="extend-session-btn">연장</button>
        <span id="session-timer"></span>
    </div>
</div>
<script>
let contextPath = "${pageContext.request.contextPath}";

const isAdmin = "<%= session.getAttribute("id") != null && session.getAttribute("id").equals("admin") %>" === "true";
const logoutURL = isAdmin ? contextPath + "/adminlogout" : contextPath + "/user/logout";
const extendURL = isAdmin ? contextPath + "/user/extend-session" : contextPath + "/user/extend-session";

const loginTime = <%= session.getAttribute("loginTime") != null ? "\"" + session.getAttribute("loginTime") + "\"" : "null" %>;

    if (loginTime !== null) {
        const sessionDuration = 30 * 60 * 1000; // 30분
        let sessionEndTime = parseInt(loginTime) + sessionDuration;
        let alertShown = false;
        
        const timerEl = document.getElementById("session-timer");
        const extendBtn = document.getElementById("extend-session-btn");   
        
        function updateTimer() {
            const now = new Date().getTime();
            const remaining = sessionEndTime - now;
            
            if (remaining <= 0) {
                timerEl.textContent = "세션이 만료되었습니다.";
                alert("세션이 만료되어 로그아웃됩니다.");
                location.href = logoutURL; // 로그아웃 처리
                return;
            }
            const min = Math.floor(remaining / 60000);
            const sec = Math.floor((remaining % 60000) / 1000);
            timerEl.textContent = "로그아웃까지 " + min + "분 " + sec + "초";
            // 5분 이하 → 연장 버튼 노출
            if (remaining <= 5 * 60 * 1000) {
                extendBtn.style.display = "inline";
            }
            // 1분 이하 → 팝업 알림 한 번만
            if (remaining <= 60 * 1000 && !alertShown) {
                alert("세션이 1분 뒤 만료됩니다. 연장하지 않으면 자동 로그아웃됩니다.");
                alertShown = true;
            }
            setTimeout(updateTimer, 1000);
        }
        extendBtn.addEventListener("click", () => {
            fetch(contextPath +"/user/extend-session", { method: "POST" })
                .then(res => res.text())
                .then(data => {
                    if (data === "ok") {
                        alert("세션이 연장되었습니다.");
                        location.reload(); // 새로고침으로 loginTime 갱신
                    }
                });
        });
        updateTimer();
    }
</script>
</body>
</html>