app.factory 'Story', ['$resource', ($resource) ->
  $resource('/stories/:id', {id: '@id'}, {
    update: {method: 'PUT'}
    list: {method: 'GET', isArray: false}
  })
]