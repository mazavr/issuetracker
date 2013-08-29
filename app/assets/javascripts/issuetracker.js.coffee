app = angular.module('IssueTracker', ['ngResource'])     # todo: remove resource?!

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

# resources

app.factory 'Entry', ['$resource', ($resource) ->
  $resource('/stories/:id', {id: '@id'}, {
    update: {method: 'PUT'}
    list: {method: 'GET', isArray: false}
  })
]

app.factory 'User', ['$resource', ($resource) ->
  $resource('/users/:id', {id: '@id'}, {
    update: {method: 'PUT'}
  })
]

# controllers

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
    story.$update()

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

app.controller 'StoryEditCtrl', ['$scope', 'Entry', '$routeParams',  ($scope, Entry, $routeParams) ->
  $scope.story =  Entry.get({id : $routeParams.id})

  $scope.saveStory = ->
    $scope.story.$update()
]

# directives

app.directive 'stateColor', ->
  (scope, element, attrs) ->
    getClass = (state) ->
      switch state
        when 'new' then 'info'
        when 'finished' then 'success'
        when 'rejected' then 'error'
        else 'warning'
    scope.$watch attrs.stateColor, (newValue, oldValue) ->
      element.removeClass 'info success warning error'
      element.addClass getClass newValue

app.directive 'stateAction', ->
  {
    restrict: 'E'
    replace: false
    scope:
      update: '&'
      story: '='

    template: (a, b) ->
      "
      <div class=\"btn-group\" ng-show=\"story.state == 'new'\">
        <div class=\"btn dropdown-toggle btn-info\" data-toggle=\"dropdown\" href=\"#\">
          {{story.state}}
          <span class=\"caret\"></span>
        </div>
        <ul class=\"dropdown-menu\">
          <li>
            <a ng-click=\"update({story: story, attr:{state: 'accepted'}})\" rel=\"nofollow\">Accept</a>
          </li>
          <li ng-show=\"story.user\">
            <a ng-click=\"update({story: story, attr:{state: 'started'}})\" rel=\"nofollow\">Start</a>
          </li>
          <li ng-show=\"!story.user\">
            <a ng-click=\"update({story: story, attr:{}, assignUser: true})\"  rel=\"nofollow\">Take</a>
          </li>
          <li ng-show=\"!story.user\">
            <a ng-click=\"update({story: story, attr:{state: 'started'}, assignUser: true})\"  rel=\"nofollow\">Take &amp; start</a>
          </li>
          <li class=\"divider\"></li>
          <li>
            <a ng-click=\"update({story: story, attr:{state: 'rejected'}})\" rel=\"nofollow\">Reject</a>
          </li>
        </ul>
      </div>
      <span ng-show=\"story.state != 'new'\">
        {{story.state}}
      </span>
      "
  }

app.directive 'paging', ->
  {
    restrict: 'E'
    replace: true
    scope:
      pagecount: '='
      pageclick: '&'
    template:
      "
      <div class=\"pagination\">
        <ul>
          <li ng-repeat=\"page in pages\">
            <a ng-click=\"pageclick({page: $index + 1})\">{{$index + 1}}</a>
          </li>
        </ul>
      </div>
      "
    link: (scope) ->
      scope.$watch 'pagecount', (count) ->
        scope.pages = new Array count
  }