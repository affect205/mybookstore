/**
 * Created with IntelliJ IDEA.
 * User: Alexey Balyschev
 * Date: 16.01.16
 * Time: 18:41
 * Корневой модуль приложения. Добавление во все jsp страницы
 */
var bookstoreApp = angular.module("bookstoreApp", ['ngResource']);
bookstoreApp.config(['$httpProvider', function ($httpProvider) {
    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8';
}]);