$(document).ready(function() {

  if($('.carousel-homeslider #carousel').length > 0){
     carouselSlider();
    $('.carousel-homeslider').css('height', 'auto');
  }

});

function carouselSlider(){

   var auto = parseInt(auto_play);
  if(auto){
    auto = parseInt(speed_slider);
  }

  $('.carousel-homeslider #carousel').slick({
    dots: false,
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-slider"  tabindex="0" role="button"><i class="material-icons">arrow_back</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-slider"  tabindex="0" role="button"><i class="material-icons">arrow_forward</i></a>',
    autoplay: auto,
    autoplaySpeed: parseInt(speed_slider),
    speed: 1000,
  });

}


