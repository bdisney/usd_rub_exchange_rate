$(document).on 'ready turbolinks:load ajaxSuccess', ->
  $('.datetimepicker').datetimepicker
    format:'d.m.Y, H:i'

$(document).on 'ready turbolinks:load ajaxSuccess', ->
  time = 15000
  timeoutId = setTimeout (->
    clearTimeout(timeoutId)
    $('.alert').fadeOut()
  ), time
