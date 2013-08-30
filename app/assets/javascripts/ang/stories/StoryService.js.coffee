app.factory 'Entry', ['$resource', ($resource) ->
  $resource('/stories/:id', {id: '@id'}, {
    update: {method: 'PUT'}
    list: {method: 'GET', isArray: false}
  })
]