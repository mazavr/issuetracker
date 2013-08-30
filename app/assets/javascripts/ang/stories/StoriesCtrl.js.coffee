app.controller 'StoriesCtrl', ['$scope', 'Entry', '$rootScope', 'User', '$location', '$routeParams', '$route', ($scope, Entry, $rootScope, User, $location, $routeParams, $route) ->

#  getFilterParams = ->
#    params = {}
#    (params["q[#{k}]"] = v if v) for k, v of $scope.search
#    params

#  alert 'asdf'
#  console.log Entry.list()
  Entry.list (data) ->
    $scope.entries = data.stories
    $scope.paging = data.paging

  #  console.log $scope.users
  $scope.users = User.query()

  $scope.states = ['new', 'accepted', 'started', 'finished', 'rejected']

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry) # don't wait for server response. May use callback instead.
    $scope.entries.push entry
    $scope.newEntry = {}

  $scope.removeEntry = (idx) ->
    Entry.delete $scope.entries[idx]
    $scope.entries.splice idx, 1

  $scope.updateStory = (story, attr, assignUser) ->
    attr.user_id = $rootScope.user_id if assignUser
    angular.extend story, attr

    Entry.update story, (q) ->
      story = q # todo: we need to view new prop in grid
      angular.extend story, {}

  $scope.pageClick = (page) ->
    params = {page: page}
    (params["q[#{k}]"] = v if v) for k, v of $scope.search

    Entry.list(params, (data) ->
      $scope.entries = data.stories
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

    #    $scope.entries = Entry.query(params)
    Entry.list(params, (data) ->
      $scope.entries = data.stories
      $scope.paging = data.paging
    )

]