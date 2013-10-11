app.factory 'Notifications', ->
  {
    show: (text, type='information') ->
      noty
        text: text
        layout: 'topRight'
        timeout: 2000
        type: type
  }
