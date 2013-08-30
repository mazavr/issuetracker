app = angular.module('IssueTracker', ['ngResource'])
window.app = app

app.config(['$httpProvider', (provider) -> provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')])

app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/',
    {
      templateUrl: '/tmpl/stories_index.html'
      controller: 'StoriesCtrl'
    })
    .when('/stories/:id/edit',
    {
      templateUrl: '/tmpl/story_edit.html'
      controller: 'StoryEditCtrl'
    })
]