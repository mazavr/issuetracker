app.controller 'StoryEditCtrl', ['$scope', 'Story', '$routeParams',  ($scope, Story, $routeParams) ->
  $scope.story =  Story.get({id : $routeParams.id})

  $scope.saveStory = ->
    $scope.story.$update()
]