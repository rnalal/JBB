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
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>  <%-- Chart.js CDN --%>
<style>
	html, body {
	    height: 100%;
	    margin: 0;
	    padding: 0;
	}
	
	.content-container {
		display: flex;
		align-items: stretch; /* 높이를 동일하게 맞춤 */
		min-height: 100vh;
	}
	
	.chart1{
		display:flex;	
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
	
    .chart-container {
        display: flex;
        justify-content: left;
        flex-wrap: wrap;
        gap: 20px;
        margin-top: 20px;
    }
    
    .container {
        display: flex;
        flex-direction: column;
        align-items: left;
        margin-left:100px;
    }

    .chart-box {
        background: white;
        padding: 10px;
        border-radius: 10px;
        width: 600px;
        text-align: left;
        border: 1px solid #5a5a5a;
    }

    canvas {
        max-width: 100%;
        height: auto;
    }
    
    .tit{
    	color:#FF8C00;
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
   	<div class="container">
        <h2 class="tit">📊 사용자 통계</h2>
        <div class="chart-container">
            <div class="chart-box">
                <h3>📅 일별 신규 가입자</h3>
                <canvas id="dailyChart"></canvas>
            </div>
            <div class="chart-box">
                <h3>📆 주별 신규 가입자</h3>
                <canvas id="weeklyChart"></canvas>
            </div>
            <div class="chart-box">
                <h3>📅 월별 신규 가입자</h3>
                <canvas id="monthlyChart"></canvas>
            </div>
        </div>
    </div>
</div>
    <!-- JSON 데이터 변환 -->
    <script>
        var dailyUsers = [];
        <c:forEach var="user" items="${dailyUsers}">
            dailyUsers.push({ date: "${user.date}", new_users: ${user.new_users} });
        </c:forEach>

        var weeklyUsers = [];
        <c:forEach var="user" items="${weeklyUsers}">
            weeklyUsers.push({ week: "${user.week}", new_users: ${user.new_users} });
        </c:forEach>

        var monthlyUsers = [];
        <c:forEach var="user" items="${monthlyUsers}">
            monthlyUsers.push({ month: "${user.month}", new_users: ${user.new_users} });
        </c:forEach>

        $(document).ready(function() {
            // 데이터 가공
            var dailyLabels = [], dailyData = [];
            $.each(dailyUsers, function(index, user) {
                dailyLabels.push(user.date);
                dailyData.push(user.new_users);
            });

            var weeklyLabels = [], weeklyData = [];
            $.each(weeklyUsers, function(index, user) {
                weeklyLabels.push(user.week+"주차");
                weeklyData.push(user.new_users);
            });

            var monthlyLabels = [], monthlyData = [];
            $.each(monthlyUsers, function(index, user) {
                monthlyLabels.push(user.month+"월");
                monthlyData.push(user.new_users);
            });

            // 콘솔 확인
            console.log("Daily Data:", dailyLabels, dailyData);
            console.log("Weekly Data:", weeklyLabels, weeklyData);
            console.log("Monthly Data:", monthlyLabels, monthlyData);

            // 차트 생성 함수
            function createChart(ctx, labels, data, labelText) {
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: labelText,
                            data: data,
                            borderColor: '#5a5a5a',
                            backgroundColor: '#ccc',
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: true,
                        aspectRatio: 2,
                        scales: {
                            yAxes: [{
                                ticks: { beginAtZero: true }
                            }]
                        },
                    animation: {
                            onComplete: function() {
                                var ctx = this.chart.ctx;
                                ctx.font = "15px Arial";  // 글꼴 스타일
                                ctx.fillStyle = "#5a5a5a";  // 글자 색상
                                ctx.textAlign = "center";
                                ctx.textBaseline = "bottom";

                                this.data.datasets.forEach((dataset, i) => {
                                    var meta = this.getDatasetMeta(i);
                                    meta.data.forEach((bar, index) => {
                                        var data = dataset.data[index];
                                        ctx.fillText(data, bar._model.x, bar._model.y - 5); // 숫자 위치 조정
                                    });
                                });
                            }
                        }
                    }
                });
            }

            // 차트 그리기
            createChart(document.getElementById('dailyChart').getContext('2d'), dailyLabels, dailyData, '일별 신규 가입자');
            createChart(document.getElementById('weeklyChart').getContext('2d'), weeklyLabels, weeklyData, '주별 신규 가입자');
            createChart(document.getElementById('monthlyChart').getContext('2d'), monthlyLabels, monthlyData, '월별 신규 가입자');
        });
    </script>
</body>
</html>