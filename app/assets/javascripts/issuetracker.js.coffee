app = angular.module("IssueTracker", ["ngResource"])

app.config(["$httpProvider", (provider) -> provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')])

app.factory "Entry", ["$resource", ($resource) ->
  $resource('/stories/:id', {id: "@id"}, {update: 'PUT'})
]

@StoriesController = ["$scope", "Entry", ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry)
    $scope.entries.push entry
    $scope.newEntry = {}
]

