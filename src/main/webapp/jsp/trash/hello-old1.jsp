<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%--<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>--%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="org.alexside.entity.Book" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
<head>
    <script src = "https://ajax.googleapis.com/ajax/libs/angularjs/1.3.3/angular.min.js"></script>
</head>
<body ng-app="bookstoreApp">
<script>
    // оздаем контроллер
    var bookstoreApp = angular.module("bookstoreApp", []);
    bookstoreApp.controller("BookListCtrl", function($scope, $http) {
        console.log("hello,alex!");
        $scope.$on('$viewContentLoaded', function(){
            console.log("load page...");
        });
    });
</script>


<h1>Message : ${message}</h1>

<%--<% response.setContentType("text/html;charset=utf-8"); request.setCharacterEncoding("utf-8"); %>--%>
<div ng-controller="BookListCtrl">
    <table width="400" border="1" cellpadding="0" cellspacing="0" ng-view>
        <tr>
            <th>#</th>
            <th>Наименование</th>
            <th>Автор</th>
            <th>год</th>
            <th>жанр</th>
        </tr>

        <%
            List<Book> bookList = (List<Book>)request.getAttribute("bookList");
            if (bookList != null) {
                for (Book book : bookList) {

        %>
        <tr>
            <td> <%= book.id %> </td>
            <td> <%= book.name %> </td>
            <td> <%= book.author %> </td>
            <td> <%= book.year %> </td>
            <td> <%= book.genre %> </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>

</body>
</html>
