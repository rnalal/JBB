<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix = "fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/WEB-INF/views/commen_notification.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<h2>내 알림</h2>
<c:if test="${empty notifications}">
  <p>받은 알림이 없습니다.</p>
</c:if>
<ul>
  <c:forEach var="n" items="${notifications}">
    <li style="${n.read? 'color:gray' : 'font-weight:bold'}">
      <a href="${ctx}${n.url}">${n.message}</a>
      <small>(${fn:substring(n.created_at,0,19)})</small>
    </li>
  </c:forEach>
</ul>
</body>
</html>