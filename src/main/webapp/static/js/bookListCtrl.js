/**
 * Created with IntelliJ IDEA.
 * User: Alexey Balyschev
 * Date: 16.01.16
 * Time: 18:41
 * Контроллер для списка книг.
 */
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
