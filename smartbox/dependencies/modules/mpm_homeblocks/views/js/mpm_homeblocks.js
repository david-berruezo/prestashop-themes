$(document).ready(function(){

  if( $('.homeBannerContent').length > 0 ){
    sizeBannerBlock();
    resizeBannerBlock($('.homeBanner'));
  }
});

function resizeBannerBlock(el) {
  var width_window = $(window).outerWidth();
  var width_page = $('#content-wrapper').width();
  var marg = (width_window - (width_page))/2;
  var w = 'calc( 100% + '+(2*marg)+'px )';
  el.css({
    marginLeft: -marg+'px',
    width: w,
  });
}

function sizeBannerBlock(){

  $('.homeBannerContent li').each(function() {
    var height = parseFloat($(this).find('.item_block_content').height())/2;
    var position = $(this).attr('data-position');

    if(position == 'center'){
      $(this).find('.item_block_content').css({top:'50%', marginTop: -height+'px'});
    }

    if(position == 'bottom'){
      $(this).find('.item_block_content').css({top:'inherit', bottom: 0});
    }

  });



}