$(document).ready(function() {
  if( $('.custom-list .custom-list-item').length > 0 ){
    sizeCustomBlock();
  }
});


function sizeCustomBlock(){
  var height_item = 50;
  $('.custom-list .custom-list-item').each(function() {
    var height_current = $(this).height();
    if(height_current > height_item){
      height_item = height_current;
    }
  });

  $('.custom-list .custom-list-item').css('height', height_item+'px');
  $('.custom-list .custom-list-item .custom-item-img').css('height', height_item+'px');
}