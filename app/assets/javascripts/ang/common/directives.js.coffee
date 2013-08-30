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