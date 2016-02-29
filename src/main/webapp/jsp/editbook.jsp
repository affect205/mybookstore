<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru">
<head>
    <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
    <script src = "https://ajax.googleapis.com/ajax/libs/angularjs/1.3.3/angular-resource.js"></script>
    <script>
        var bookstoreApp = angular.module("bookstoreApp", ['ngResource']);
        bookstoreApp.config(['$httpProvider', function ($httpProvider) {
            $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
        }]);
        bookstoreApp.controller("saveBookCtrl", function($scope, $rootScope, $http) {
            // Контроллер редактирования книг
            var bookId = document.getElementById("bookId").value;
            $scope.baseData = {};
            $scope.baseData.title = bookId ? "Книга #" + bookId : "Новая книга";

            $scope.saveBook = {};
            $scope.saveBook = function (saveBook, resultVarName) {
                var formData = new FormData();
                $http({
                    method: 'POST',
                    url: "http://localhost:8088/bookstore/ws/addBook",
                    headers: {'Content-Type': undefined},
                    data: {
                        file: document.getElementById("bookFile").files[0],
                        name: newBook.name,
                        genre: newBook.genre,
                        author: newBook.author,
                        year: newBook.year
                    },
                    transformRequest: function(data) {
                        var formData = new FormData();
                        formData.append("file", data.file);
                        formData.append("name", data.name);
                        formData.append("author", data.author);
                        formData.append("year", data.year);
                        formData.append("genre", data.genre);
                        return formData;
                    }
                }).success(function(data, status) {
                            $scope[resultVarName] = data
                        }).error(function (data, status, headers, config) {
                            $scope[resultVarName] = data;
                        });
                $rootScope.getBookList();
            };

            $scope.deleteBook = function() {
                var isDel = confirm("Удалить книгу из библиотеки?");
                console.log("delete book: " + isDel);

            };
        });
    </script>
</head>
<style>
    label {
        width:120px;
        display: inline-block;
    }
</style>
<body ng-app="bookstoreApp">
<h2>${message}</h2>
<h3>${menu}</h3>
<fieldset ng-controller="saveBookCtrl">
    <legend><b>{{baseData.title}}</b></legend>
    <form name="saveBookForm" method="POST" enctype="multipart/form-data" novalidate>
        <input id="bookId" type="hidden" name="bookId" value="${book.id}" />
        <label for="bookAuthor">Автор:</label>
        <input id="bookAuthor" type="text" name="bookAuthor" ng-model="saveBook.author" value="${book.author}" required /><br />
        <label for="bookName">Название:</label>
        <input id="bookName" type="text" name="bookName" ng-model="saveBook.name" value="${book.name}" required /><br />
        <label for="bookYear">Год:</label>
        <input id="bookYear" type="text" name="bookYear" ng-model="saveBook.year" value="${book.year}" required /><br />
        <label for="bookGenre">Жанр:</label>
        <input id="bookGenre" type="text" name="bookGenre" ng-model="saveBook.genre" value="${book.genre}" required /><br />
        <label for="bookDescription">Описание:</label>
        <textarea id="bookDescription" name="bookDescription" ng-model="saveBook.description">${book.description}</textarea><br />
        <label for="bookFile">Файл:</label>
        <input id="bookFile" type="file" name="bookFile" value="${book.filename}" required /><br />
        <br />
        <%--ng-disabled="newBookForm.$invalid"--%>
        <button id="saveBookBtn" type="submit" ng-click="saveBook(editBook)">Сохранить</button>
        <button id="deleteBookBtn" ng-click="deleteBook()">Удалить</button>
    </form>
    <br />
</fieldset>
</body>
</html>