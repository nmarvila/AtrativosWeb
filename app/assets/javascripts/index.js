$(document).on("ready", function(){
$('.message .close').on("click", function(event) {
  $(this)
    .closest('.message')
    .fadeOut("slow")
  ;
});
});