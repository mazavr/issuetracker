app.controller 'StoriesCtrl', ['$scope', 'Story', '$rootScope', 'User', '$location', '$routeParams', '$route', 'Notifications', ($scope, Story, $rootScope, User, $location, $routeParams, $route, Notifications) ->

#  getFilterParams = ->
#    params = {}
#    (params["q[#{k}]"] = v if v) for k, v of $scope.search
#    params

  Story.list (data) ->
    $scope.stories = data.stories
    $scope.paging = data.paging

  #  console.log $scope.users
  $scope.users = User.query()

  $scope.states = ['new', 'accepted', 'started', 'finished', 'rejected']

  $scope.addStory = ->
    story = Story.save($scope.newStory, (st) ->
      console.log st
      angular.extend story, st)
    $scope.stories.push story
    $scope.newStory = {}

  $scope.removeStory = (idx) ->
    Story.delete $scope.stories[idx], -> Notifications.show('Deleted')
    $scope.stories.splice idx, 1

  $scope.updateStory = (story, attr, assignUser) ->
    attr.user_id = $rootScope.user_id if assignUser
    angular.extend story, attr

    Story.update story, (q) ->
      angular.extend story, q # todo: we need to view new prop in grid

  $scope.pageClick = (page) ->
    params = {page: page}
    (params["q[#{k}]"] = v if v) for k, v of $scope.search

    Story.list(params, (data) ->
      $scope.stories = data.stories
      $scope.paging = data.paging
    )

  $scope.filterStories = ->  # todo: use the address
    params = {}
    (params["q[#{k}]"] = v if v) for k, v of $scope.search
    #    $location.search params
    #    console.log $routeParams
    #    $location
    #    $location.replace()

    #    $route.reload();

    #    $scope.stories = Story.query(params)
    Story.list(params, (data) ->
      $scope.stories = data.stories
      $scope.paging = data.paging
    )

]