$(function() {
  $('.fullscreen-icon').on('click', function() {
    $('#code-diff').toggleClass('takeover');
  });

  $('button#review-issue-attach').on('click', function() {
    $('button#review-issue-attach').hide();
    $('div#review-issue-container').show();
  })

  $('.tag').on('click', function(e) {
    $(e.target).next('.modal').addClass('is-active')
  })
  
  $('.modal button.close').on('click', function(e) {
    $(e.target).closest('.modal').removeClass('is-active');
  })

  $('#reviews-filter-sort').on('change', function() {
    $('#reviews-filter-form').submit();
  })
})
