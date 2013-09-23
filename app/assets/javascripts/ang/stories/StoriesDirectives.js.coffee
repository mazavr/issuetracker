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

    template: (a, b) ->      # todo: use string? not func...
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

app.directive 'imageList', ->
  {
    restrict: 'E'
    replace: true
    scope:
      delete: '&'
      images: '='
    template:
      "
      <div ng-repeat=\"image in images\">
        <img src=\"{{image.file.file.url}}\" ng-click=\"delete()\" />
      </div>
      "

  }