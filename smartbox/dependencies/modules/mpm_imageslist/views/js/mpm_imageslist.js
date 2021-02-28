$(document).ready(function(){

  $(document).on('click', '.images-list-block .prev-img', function(){
    var el = $(this).parents('.product-miniature-'+$(this).attr('data-id-product'));
    scrollImages('prev', el);
  });

  $(document).on('click', '.images-list-block .next-img', function(){
    var el = $(this).parents('.product-miniature-'+$(this).attr('data-id-product'));
      scrollImages('next', el);
  });

});


function scrollImages(type, el) {

  var current_item = el.find('.list-images .image-item.selected');

  if(type == 'next'){
    if(current_item.next().length > 0){
      var item = current_item.next();
    }
    else{
      var item = el.find('.list-images .image-item.first');
    }
  }

  if(type == 'prev'){
    if(current_item.prev().length > 0){
      var item = current_item.prev();
    }
    else{
      var item = el.find('.list-images .image-item.last');
    }
  }

  var href = item.attr('data-href');

  el.find('.product-thumbnail img').attr('src', href);
  el.find('.list-images .image-item').removeClass('selected');

  item.addClass('selected')
}