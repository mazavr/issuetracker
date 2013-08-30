app.controller 'StoryEditCtrl', ['$scope', 'Entry', '$routeParams',  ($scope, Entry, $routeParams) ->
  $scope.story =  Entry.get({id : $routeParams.id})

  $scope.saveStory = ->
    $scope.story.$update()
]