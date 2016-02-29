<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:url value="/static/img" var="imgSrc" />

<div ng-controller="BookListCtrl">
    <table width="600" border="1" cellpadding="0" cellspacing="0" ng-view>
        <tr>
            <th>#</th>
            <th>Наименование</th>
            <th>Автор</th>
            <th>Год</th>
            <th>Жанр</th>
            <th>Ссылка</th>
            <th>Действие</th>
        </tr>
        <tr ng-repeat="book in bookList">
            <td>{{book.id}}</td>
            <td><a ng-href="http://localhost:8088/bookstore/book/{{book.id}}">{{book.name}}</a></td>
            <td>{{book.author}}</td>
            <td>{{book.year}}</td>
            <td>{{book.genre}}</td>
            <td><a ng-href="http://localhost:8088/bookstore/ws/file/{{book.id}}">{{book.ref}}</a></td>
            <td>
                <a ng-href="http://localhost:8088/bookstore/edit/{{book.id}}">
                    <img ng-src="${imgSrc}/edit.png" width="24" height="24" title="Редактировать книгу">
                </a>
                <a ng-href="http://localhost:8088/bookstore/delete/{{book.id}}">
                    <img ng-src="${imgSrc}/delete.png" width="24" height="24" title="Удалить книгу">
                </a>
            </td>
        </tr>
    </table>
    <button id="refreshBookListBtn" ng-click="getBookList()">Обновить</button>
    <button id="addBookBtn" ng-click="clickAddBookBtn()">Добавить</button>
    <div ng-hide="hideAddBook" ng-class="ng-hide">
        <jsp:include page="addBookTmpl.jsp"></jsp:include>
    </div>
</div>