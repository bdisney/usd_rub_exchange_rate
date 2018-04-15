$(document).on 'ready turbolinks:load ajaxSuccess', ->
  $('.datetimepicker').datetimepicker
    format:'d.m.Y, H:i'
