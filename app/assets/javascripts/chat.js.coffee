$ ->
  socket = new WebSocket "ws://#{window.location.host}/chat"

  socket.onmessage = (e) ->
    if e.data.length
      $('#chat-window').append "#{e.data}<br>"

  $('body').on 'submit', 'form.chat', (e) ->
    e.preventDefault()
    $input = $(this).find('input')
    socket.send $input.val()
    $input.val(null)