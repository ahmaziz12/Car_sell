$(document).on('turbolinks:load', function() {
  $('.color_field').on('change', function() {
    if($(this).find(":selected").text() == "Other")
    {
      $('.color_detail').removeClass("d-none")
    }
    else
    {
      $('.color_detail').addClass("d-none")
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
});


