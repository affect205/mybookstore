<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:url value="/static/img" var="imgSrc" />

<div ng-controller="AddBookCtrl">
    <fieldset>
        <legend><b>Новая книга</b></legend>
        <form name="newBookForm" method="POST" enctype="multipart/form-data" novalidate>
            <label for="bookAuthor">
                Автор:
            </label>
            <input id="bookAuthor" type="text" name="bookAuthor" ng-model="newBook.author" required /><br />
            <label for="bookName">
                Название:
            </label>
            <input id="bookName" type="text" name="bookName" ng-model="newBook.name" required /><br />
            <label for="bookYear">
                Год:
            </label>
            <input id="bookYear" type="text" name="bookYear" ng-model="newBook.year" required /><br />
            <label for="bookGenre">
                Жанр:
            </label>
            <input id="bookGenre" type="text" name="bookGenre" ng-model="newBook.genre" required /><br />
            <br />
            <label for="bookDescription">
                Описание:</label>
            <textarea id="bookDescription" name="bookDescription" ng-model="newBook.description"></textarea>
            <br />
            <label for="bookFile">
                Файл:
            </label>
            <input id="bookFile" type="file" name="bookFile" required /><br />
            <br />
            <%--ng-disabled="newBookForm.$invalid"--%>
            <button type="submit"
                    ng-click="submitData(newBook, 'ajaxSubmitResult')">
                Сохранить
            </button>
        </form>
        <br />
    </fieldset>
</div>