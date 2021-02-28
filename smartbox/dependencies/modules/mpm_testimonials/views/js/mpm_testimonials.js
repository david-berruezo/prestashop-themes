$(document).ready(function(){
  if( $('.testimonials-list').length > 0){
    testimonialsSlider();
    $('.testimonials').css('height', 'auto');
  }

});

function testimonialsSlider() {
  $('.testimonials-list').slick({
    dots: false,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-products"  tabindex="0" role="button"><i class="material-icons">arrow_back</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-products"  tabindex="0" role="button"><i class="material-icons">arrow_forward</i></a>',
    autoplay: true,
    autoplaySpeed: 3000
  });

}