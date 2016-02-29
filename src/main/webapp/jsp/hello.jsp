<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
<head>
    <spring:url value="/static/img" var="imgSrc" />

    <link rel="stylesheet" type="text/css" href="<spring:url value="/static/css/style.css"/>">

    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.3/angular-resource.js"></script>

    <script src="<spring:url value="/static/js/bookstoreApp.js"/>" ></script>
    <script src="<spring:url value="/static/js/bookListCtrl.js"/>" ></script>
    <script src="<spring:url value="/static/js/addBookCtrl.js"/>" ></script>

</head>
<body ng-app="bookstoreApp">
<h2>Message : ${message}</h2>
<jsp:include page="templates/bookListTmpl.jsp"></jsp:include>
</body>
</html>
