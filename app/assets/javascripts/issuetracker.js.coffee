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

app.factory 'Entry', ['$resource', ($resource) ->
  $resource('/stories/:id', {id: '@id'}, {
    update: {method: 'PUT'}
  })
]

app.controller 'StoriesCtrl', ['$scope', 'Entry', ($scope, Entry) ->
  $scope.entries = Entry.query()

  $scope.addEntry = ->
    entry = Entry.save($scope.newEntry) # don't wait for server response. May use callback instead.
    $scope.entries.push entry
    $scope.newEntry = {}

  $scope.removeEntry = (idx) ->
    $scope.entries[idx].$delete()
    $scope.entries.splice idx, 1

  $scope.updateStory = (story, attr, assignUser) ->
    attr.user_id = $scope.user_id if assignUser
    angular.extend story, attr
    story.$update()
]

app.controller 'StoryEditCtrl', ['$scope', 'Entry', '$routeParams',  ($scope, Entry, $routeParams) ->
  $scope.story =  Entry.get({id : $routeParams.id})

  $scope.saveStory = ->
    $scope.story.$update()
]

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
            <a href=\"/stories/85?story%5Bstate%5D=rejected\" data-method=\"put\" rel=\"nofollow\">Reject</a>
          </li>
        </ul>
      </div>
      <span ng-show=\"story.state != 'new'\">
        {{story.state}}
      </span>
      "
  }


