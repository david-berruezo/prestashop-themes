$(document).ready(function(){
  if( $('.supplier-list-homepage').length > 0){
    suppliersSlider();
    resizeSuppliers($('.container_supplier'));
    $('.container_supplier').css('height', 'auto');
  }
});
function resizeSuppliers(el) {
  var width_window = $(window).outerWidth();
  var width_page = $('#content-wrapper').width();
  var marg = (width_window - (width_page))/2;
  var w = 'calc( 100% + '+(2*marg)+'px )';
  el.css({
    marginLeft: -marg+'px',
    width: w,
  });
}
function suppliersSlider() {
  $('.supplier-list-homepage').slick({
    dots: false,
    infinite: true,
    slidesToShow: 5,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-products"  tabindex="0" role="button"><i class="material-icons">arrow_back</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-products"  tabindex="0" role="button"><i class="material-icons">arrow_forward</i></a>',
    autoplay: true,
    autoplaySpeed: 3000,
    responsive: [
      {
        breakpoint: 1200,
        settings: {
          slidesToShow: 4,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 1000,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 700,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
        },
      },
      {
        breakpoint: 550,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      }
    ]
  });

}