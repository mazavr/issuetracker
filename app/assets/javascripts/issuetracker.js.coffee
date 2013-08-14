app = angular.module('IssueTracker', ['ngResource'])

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

app.factory 'Entry', ['$resource', ($resource) ->
  $resource('/stories/:id', {id: '@id'}, {
    update: {method: 'PUT'}
  })
]

app.controller 'StoriesCtrl', ['$scope', 'Entry', ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    Entry.save($scope.newEntry, (entry, headers) ->
      $scope.entries.push entry
      $scope.newEntry = {}
    )

  $scope.removeEntry = (idx) ->
    $scope.entries[idx].$delete -> $scope.entries.splice idx, 1
]

app.controller 'StoryEditCtrl', ['$scope', 'Entry', '$routeParams',  ($scope, Entry, $routeParams) ->
  $scope.story =  Entry.get({id : $routeParams.id})

  $scope.saveStory = ->
    $scope.story.$update()
]

