$(document).ready(function(){

  if( $('.customfeatured_block .tab_featured').length > 0){
    $(document).on('click', '.customfeatured_block .tab_featured', function(e){
      if(!$(this).hasClass('active')){
        $('.customfeatured_block .tab_featured').removeClass('active');
        $(this).addClass('active');
        getFeaturedContent($(this).attr('data-tab'));
      }
    });
  }
    if( $('.mpm_customfeatured').length > 0){
      sliderCustomfeatured();
      $('.block_featured_slider').css('overflow', 'inherit');
      $('.block_featured_slider').css('height', 'auto');
    }

});

function getFeaturedContent(id){

    var basePath = $('input[name="basePath"]').val();
    $.ajax({
      type: "POST",
      url: basePath+'index.php?rand=' + new Date().getTime(),
      dataType: 'json',
      async: true,
      cache: false,
      data: {
        ajax	: true,
        token	: "",
        controller: 'AjaxForm',
        fc: 'module',
        module : 'mpm_customfeatured',
        action: 'show',
        id_shop: $('input[name="id_shop"]').val(),
        id_lang: $('input[name="id_lang"]').val(),
        id: id,
      },
      beforeSend: function(){
        $(".progres_bar_featured").show();
      },
      success: function(json) {
        if(json['form']){
          $('.home_featured_product_list').replaceWith(json['form']);
          sliderCustomfeatured();
          $('.block_featured_slider').css('height', 'auto');
        }
      }
    });

}




function sliderCustomfeatured() {
  $('.customfeatured_slider').slick({
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