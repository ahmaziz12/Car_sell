$(document).on('turbolinks:load', function() {
  $('.color_field').on('change', function() {
    if($(this).find(":selected").text() == "Other")
    {
      $('.color_detail').removeClass("d-none");
    }
    else
    {
      $('.color_detail').addClass("d-none");
    }
  });

  var $temp = $("<input>");
  var $url = $(location).attr('href');
  $('#btn').click(function() {
    $("body").append($temp);
    $temp.val($url).select();
    document.execCommand("copy");
    $temp.remove();
  });

  $('#filter-button').on('click', function() {
    if ($('#filter-button').prop("text") == "Advanced filters")
    {
      $('#Advanced-filters').removeClass("d-none");
      $('#filter-button').prop("text","Simple Search");
    }
    else if ($('#filter-button').prop("text") == "Simple Search")
    {
      $('#Advanced-filters').addClass("d-none");
      $('#filter-button').prop("text","Advanced filters");
    }
  });

});
