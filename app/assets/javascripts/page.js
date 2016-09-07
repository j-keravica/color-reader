$(function(){
  $("#show-options").click(function() {
    var e = $("#advanced-options");
    if (e.is(":visible")) {
      e.hide();
      $(this).text("Show advanced options");
    } else {
      e.show();
      $(this).text("Hide advanced options");
    }
  });
});
