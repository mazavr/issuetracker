app.controller 'StoryEditCtrl', ['$scope', 'Story', '$routeParams', '$location',  ($scope, Story, $routeParams, $location) ->
  $scope.story =  Story.get({id : $routeParams.id})

  $scope.saveStory = ->
    $scope.story.$update()
    $location.path('/')
]