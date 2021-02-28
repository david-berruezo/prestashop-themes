$(document).ready(function(){


  $('.page-content .search_widget_submit').removeClass('disabled')

  if($('.product-accessories').length>0){
    productsCategorySlider($('.product-accessories .products'));
  }

  if($('.featured-products').length>0){
    productsCategorySlider($('.featured-products .products'));
  }

  if($('.crossseling-products').length>0){
    productsCategorySlider($('.crossseling-products .products'));
  }



  if (($(window).width()+scrollCompensate()) < 768)
  {
    $('.topMenuBlock').addClass('mobile')
    $('.topMenuBlock').removeClass('desktop')
  }
  else{
    $('.topMenuBlock').addClass('desktop')
    $('.topMenuBlock').removeClass('mobile')
  }

  $(document).on('click', '#search-button', function(e){
    if($(this).hasClass('active')){
      $('#search_widget').removeClass('active');
      $(this).removeClass('active');
    }
    else{
      $('#search_widget').addClass('active');
      $(this).addClass('active');
    }
  });

  $(document).on('click', '.close_button', function(e){
    e.preventDefault();
      $('#search_widget').removeClass('active');
      $('#search-button').removeClass('active');
  });

  $(document).on('click', '.block-product-modal', function(){
    setTimeout(function () {
      productImagesModal()
    }, 300)
  });

  $(document).on('click', '.column-arrows-add', function(){
    $(this).removeClass('active');
    $(this).next().addClass('active');
    $(this).parent().next().show();
  });

  $(document).on('click', '.column-arrows-remove', function(){
    $(this).removeClass('active');
    $(this).prev().addClass('active');
    $(this).parent().next().hide();
  });

  $(document).on('click', '.quickview  .thumb-container', function(e){
    $('.quickview  .thumb-container').removeClass('selected');
    $(this).addClass('selected');
    var src = $(this).find('.js-thumb').attr('data-image-medium-src') ;

    $('.quickview .product-cover .js-qv-product-cover').attr('src', src);

  });

  $(document).on('click', '._desktop_search_icon', function(){
    if($(this).hasClass('active')){
      $(this).removeClass('active');
      $('#search_widget').removeClass('active');
    }
    else{
      $(this).addClass('active');
      $('#search_widget').addClass('active');
    }
  });

  $(document).on('click', '.search_close', function(e){
    e.preventDefault();
    $('._desktop_search_icon').removeClass('active');
    $('#search_widget').removeClass('active');
  });

  $(document).on('click', '.product_images_block .product-images .thumb-container-img', function(e){
    e.preventDefault();

    $('.product_images_block .product-images .thumb-container-img').removeClass('selected');
    $(this).addClass('selected');

    var url = $(this).find('.thumb_item').attr('data-image-medium-src');
    $('.product-cover-img .js-qv-product-cover').attr('src', url)
  });



  window.onscroll = function() {

    if($('#products').length>0){
      if (($(window).width()+scrollCompensate()) >= 768)
      {
        if($.cookie){
          if($.cookie("category_view")){
            displayListGrid($.cookie("category_view"));
          }
          else{
            displayListGrid('grid');
          }
        }
      }
      else{
        displayListGrid('grid');
      }
    }

    if (($(window).width()+scrollCompensate()) < 768)
    {
      $('.topMenuBlock').addClass('mobile')
      $('.topMenuBlock').removeClass('desktop')
    }
    else{
      $('.topMenuBlock').addClass('desktop')
      $('.topMenuBlock').removeClass('mobile')
    }

  }

});


function productImagesModal() {

  $('.js-product-images-modal  .js-modal-product-images').slick({
    dots: false,
    infinite: true,
    vertical: true,
    slidesToShow: 7,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-product-img"  tabindex="0" role="button"><i class="material-icons">keyboard_arrow_up</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-product-img"  tabindex="0" role="button"><i class="material-icons">keyboard_arrow_downt</i></a>',
    autoplay: false,

  });
  $('.product_images_block').css('height', 'auto')
}

function productsImageSlider(el, n){
  el.slick({
    dots: false,
    infinite: true,
    slidesToShow: n,
    vertical: true,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-img"  tabindex="0" role="button"><i class="material-icons">keyboard_arrow_up</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-img"  tabindex="0" role="button"><i class="material-icons">keyboard_arrow_downt</i></a>',
    autoplay: false,
    responsive: [
      {
        breakpoint: 445,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 1,
        }
      }
    ]

  });
  $('.product_images_block').css('height', 'auto')
}


function productsCategorySlider(el ){
  el.slick({
    dots: false,
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 1,
    prevArrow: '<a onclick=""  data-role="none" class="slick-prev slick-prev-products"  tabindex="0" role="button"><i class="material-icons">arrow_back</i></a>',
    nextArrow: '<a onclick=""  data-role="none" class="slick-next slick-next-products"  tabindex="0" role="button"><i class="material-icons">arrow_forward</i></a>',
    autoplay: true,
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
        breakpoint: 650,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        }
      }
    ]
  });
}


function scrollCompensate()
{
  var inner = document.createElement('p');
  inner.style.width = "100%";
  inner.style.height = "200px";

  var outer = document.createElement('div');
  outer.style.position = "absolute";
  outer.style.top = "0px";
  outer.style.left = "0px";
  outer.style.visibility = "hidden";
  outer.style.width = "200px";
  outer.style.height = "150px";
  outer.style.overflow = "hidden";
  outer.appendChild(inner);

  document.body.appendChild(outer);
  var w1 = inner.offsetWidth;
  outer.style.overflow = 'scroll';
  var w2 = inner.offsetWidth;
  if (w1 == w2) w2 = outer.clientWidth;

  document.body.removeChild(outer);

  return (w1 - w2);
}