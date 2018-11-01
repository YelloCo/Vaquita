$(function() {
  $('#repositories-advanced-settings').on('click', function(e) {
    $(e.target).nextAll('.modal').addClass('is-active')
  })
  
  $('.modal button.is-success').on('click', function(e) {
    $(e.target).closest('.modal').removeClass('is-active');
  })
})
