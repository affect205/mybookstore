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

    <script src = "http://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
    <script src = "https://ajax.googleapis.com/ajax/libs/angularjs/1.3.3/angular-resource.js"></script>

    <script>
        var bookstoreApp = angular.module("bookstoreApp", ['ngResource']);
        bookstoreApp.config(['$httpProvider', function ($httpProvider) {
            $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
        }]);

        bookstoreApp.controller("BookListCtrl", function($scope, $rootScope, $http) {
            // Контроллер списка книг
            $rootScope.bookList = [];
            $rootScope.getBookList = function() {
                $http.post("http://localhost:8088/bookstore/ws/getBookList", null)
                        .success(function(resp, status, headers, config) {
                            console.log("ajax success" + resp);
                            $rootScope.bookList = resp.data ? resp.data : [];

                        })
                        .error(function(resp, status, headers, config) {
                            console.log("ajax error! " + resp);
                            $rootScope.bookList = [];
                        });
            };

            $rootScope.getBookList();
            $scope.hideAddBook = true;
            $scope.hideAddBookForm = function(hide) {
                $scope.hideAddBook = hide;
            }
            $scope.hideAddBookForm(true);
            $scope.clickAddBookBtn = function() {
                $scope.hideAddBookForm(!$scope.hideAddBook);
            }

        });

        bookstoreApp.controller("AddBookCtrl", function($scope, $rootScope, $http) {
            // Контроллер добавления книги
            $scope.newBook = {};

            $scope.submitData = function (newBook, resultVarName) {
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
                            $scope[resultVarName] = data;
                            $rootScope.getBookList();
                        }).error(function (data, status, headers, config) {
                            $scope[resultVarName] = data;
                        });
            };
        });
    </script>
</head>
<body ng-app="bookstoreApp">
<div ng-controller="BookListCtrl">
    <h2>Message : ${message}</h2>
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
    <div ng-controller="AddBookCtrl" ng-hide="hideAddBook" ng-class="ng-hide">
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
            <strong><label for="submitDebugText">Ответ сервера:</label></strong><br />
            <textarea id="submitDebugText">{{ajaxSubmitResult | json}}</textarea>
        </fieldset>
    </div>
</div>
</body>
</html>
