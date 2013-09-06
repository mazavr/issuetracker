app.factory 'Notifications', ->
  {
    show: (text, type) ->
      console.log "#{type}: #{text}"
  }
