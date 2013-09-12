app.factory 'Notifications', ->
  {
    show: (text, type) ->
      noty
        text: text
  }
