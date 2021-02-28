$(document).ready(function(){
  if( $('.featured-list.products').length > 0){
    sliderCrossseling();
    $('.block_featured_slider').css('overflow', 'inherit');
    $('.block_featured_slider').css('height', 'auto');
  }
});

function sliderCrossseling() {
  $('.featured-list.products').slick({
    dots: false,
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-products"  tabindex="0" role="button"><i class="material-icons">arrow_back</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-products"  tabindex="0" role="button"><i class="material-icons">arrow_forward</i></a>',
    autoplay: false,
    autoplaySpeed: 3000,
    responsive: [
      {
        breakpoint: 1200,
        settings: {
          slidesToShow: 3,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 1000,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
        }
      },
      {
        breakpoint: 700,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      }
    ]
  });

}