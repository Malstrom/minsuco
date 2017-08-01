App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (event) ->
    $('#events').prepend event.message

    if $('#event_counter').length == 0
      $('#counter').append '<div id="event_counter" class="label label-danger">1</div>'
    else
      value = parseInt($("#event_counter").text(), 10) + 1
      $("#event_counter").text(value)


