App.activity = App.cable.subscriptions.create "ActivityChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (event) ->
#    alert event.content
#    # Called when there's incoming data on the websocket for this channel
    $('#events').prepend event.message


    value = parseInt($("#event_counter").text(), 10) + 1
    $("#event_counter").text(value)
