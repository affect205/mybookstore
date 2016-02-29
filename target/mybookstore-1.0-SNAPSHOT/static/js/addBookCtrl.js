/**
 * Created with IntelliJ IDEA.
 * User: Alexey Balyschev
 * Date: 16.01.16
 * Time: 18:41
 * Контроллер для добавления книги.
 */
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
                if (typeof $rootScope.getBookList === "function") {
                    $rootScope.getBookList();
                }
            }).error(function (data, status, headers, config) {
                $scope[resultVarName] = data;
            });
    };
    // запрос на получение информации по книге
    var bookId = document.getElementById('editBookId');
    console.log("bookId is: " + bookId.value);
    $scope.getBookById = function(bookId) {
        $http.post("http://localhost:8088/bookstore/ws/getBookById", {id: bookId})
            .success(function(resp, status, headers, config) {
                console.log("ajax success" + resp);
                $rootScope.bookList = resp.data ? resp.data : [];

            })
            .error(function(resp, status, headers, config) {
                console.log("ajax error! " + resp);
                $rootScope.bookList = [];
            });
    };
    if (bookId.value) $scope.getBookById(bookId.value);
});