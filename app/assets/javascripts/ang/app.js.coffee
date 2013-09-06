app = angular.module('IssueTracker', ['ngResource'])
window.app = app

app.config(['$httpProvider', (provider) ->
            provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

            httpStatusCodeInterceptorFactory = ($q) ->
              onSuccess = (response) -> response

              onError = (response) ->
                # todo: show global error dialog
                $q.reject(response)

              (promise) -> promise.then onSuccess, onError

            provider.responseInterceptors.push httpStatusCodeInterceptorFactory
  ])

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