/*
 * 2002-2018 Zemez
 *
 * JX Wishlist
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the General Public License (GPL 2.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/GPL-2.0
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade the module to newer
 * versions in the future.
 *
 *  @author    Zemez
 *  @copyright 2002-2018 Zemez
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */
let jxwishlist = {
  list: function() {
    this.init = function(json) {
      if (json == '') {
        json = '[]';
      }
      this.array = JSON.parse(json);
    };
    this.extend = function(json) {
      var products = JSON.parse(json);
      for (var i = 0; i < products.length; i++) {
        this.array[this.array.length] = products[i];
      }
      return JSON.stringify(this.array);
    };
    this.add = function(elem) {
      if (this.array.indexOf(elem) == -1) {
        this.array[this.array.length] = elem;
      }
      return JSON.stringify(this.array);
    };
    this.remove = function(elem) {
      var index = this.array.indexOf(elem);
      this.array.splice(index, 1);
      return JSON.stringify(this.array);
    }
  }
};
$(document).ready(function() {
  $(':input', '#form_wishlist')
    .not(':button, :submit, :reset, :hidden')
    .val('')
    .removeAttr('checked')
    .removeAttr('selected');
  $(".edit-wishlist").click(function() {
    $('html, body').animate({scrollTop: 0}, 800);
    return false;
  });
  $('.btn-product-wishlist').click(function() {
    $(this).parent().prev().fadeToggle("slow", "linear");
    $(this).addClass('active');
  });
  $("#change_wishlist").hide();
  window.jxwl_layouts = new Array();
  $(document).on('click', '#add-new-layout', function() {
    var wishlist_name = $(this).parent().parent().attr('data-wishlist-name');
    layouts_popup(wishlist_name);
    var wishlist_id = $(this).parent().parent().attr('data-wishlist-id');
    $('#id_wishlist_popup').attr('value', wishlist_id);
    $('#name_wishlist_popup').attr('value', wishlist_name);
    $('.jxwl-step-2').hide();
  });
  $(document).on('click', '#back_button', function() {
    $('.block-container-row').remove();
    $('#jxwl-layouts-popup > .jxwl_popup_item, .jxwl-step-1').show();
    $('.jxwl-step-2').hide();
  });
  $(document).on('click', '#jxwl-layouts-popup > .jxwl_popup_item > .items', function() {
    let layout_type = $(this).attr('id');
    addNewRow(layout_type);
    $('#jxwl-layouts-popup > .jxwl_popup_item, .jxwl-step-1').hide();
    $('.jxwl-step-2').show();
    $("#back_button_step_2").hide();
  });
  $(document).on('click', '.block-container-row .jxwl_popup_item li', function() {
    $(this).addClass('active');
    $('.block-container-row .jxwl_popup_item, .block-container-row .share_button, .block-container-row #back_button').hide();
    $('.block-container-product, .block-container-row .alert-warning, #clear-item').show();
    if ($('.block-container-product > div.done').length <= 0) {
      $('.block-container-row .block-container-product').append('<p class="alert alert-warning">' + wishlist_no_product + '</p>');
    }
    $("#back_button_step_2").show();
  });
  $(document).on('click', '.block-container-row .jxwl_popup_item li .jxwl-content-image', function() {
    $('.block-container-product .alert').hide();
    var products = new jxwishlist.list();
    let data_product_id = $(this).attr('data-product-id');
    products.init($('#popup_selected_products').attr('value'));
    $('#popup_selected_products').attr('value', products.remove(data_product_id));
    $('.block-container-product .product').filter('[data-product-id="' + data_product_id + '"]').removeClass('active');
    $('.block-container-product .product').filter('[data-product-id="' + data_product_id + '"]').addClass('done');
  });
  $(document).on('click', '.block-container-product .product', function(e) {
    let image_src = $(this).find('img').attr('src');
    let current_block = $('.block-container-row .jxwl_popup_item li.active .content');
    current_block.find('.content-inner').remove();
    current_block.append('<div class="content-inner"><div class="jxwl-content-image"><span class="icon-remove linearicons-cross clear-item" aria-hidden="true"></span><img class="img-fluid" src="' + image_src + '" alt="" /></div></div>');
    current_block.addClass('current');
    $('.block-container-row .jxwl_popup_item li.active .content .jxwl-content-image').attr('data-product-id', $(this).attr("data-product-id"));
    $(this).addClass('active');
    $(this).removeClass('done');
    $('.block-container-row .share_button').show();
    var products = new jxwishlist.list();
    products.init($('#popup_selected_products').attr('value'));
    var product_id = $(this).attr('data-product-id');
    $('#popup_selected_products').attr('value', products.add(product_id));
    $('.block-container-product, #back_button_step_2').hide();
    $('.block-container-row .jxwl_popup_item, .block-container-row #share_button, .block-container-row #back_button').show();
    $('.block-container-row .jxwl_popup_item li').removeClass('active');
  });
  $(document).on('click', '#back_button_step_2', function() {
    $('.block-container-row .share_button, .block-container-row .jxwl_popup_item, #back_button').show();
    $('.block-container-product, #back_button_step_2').hide();
    $('.block-container-row .jxwl_popup_item li').removeClass('active');
    $('.block-container-product .alert').remove();
    var products = new jxwishlist.list();
    products.init($('#popup_selected_products').attr('value'));
    if (typeof(data_product_id) != 'undefined' && data_product_id.length) {
      $('#popup_selected_products').attr('value', products.add(data_product_id));
      $('.block-container-product .product').filter('[data-product-id="' + data_product_id + '"]').removeClass('done');
      $('.block-container-product .product').filter('[data-product-id="' + data_product_id + '"]').addClass('active');
    }
  });
  $(document).on('click', '.clear-item', function(e) {
    e.stopPropagation();
    $(this).parent().parent().parent().removeClass('current');
    var products = new jxwishlist.list(),
      product_id = $(this).parent().attr('data-product-id');
    products.init($('#popup_selected_products').attr('value'));
    $('#popup_selected_products').attr('value', products.remove(product_id));
    $('.block-container-product .product').filter('[data-product-id="' + product_id + '"]').removeClass('active');
    $('.block-container-product .product').filter('[data-product-id="' + product_id + '"]').addClass('done');
    let element = $(this).closest('li');
    $(this).remove();
    element.find('.content-inner').remove();
  });
});

function layouts_popup(wishlist_name) {
  let jxwl_lp_content = '';
  if (jxwl_layouts.length) {
    for (var i = 0; i < jxwl_layouts.length; i++) {
      jxwl_lp_content += jxwl_layouts[i].value;
    }
  }
  $('body').append('<div id="wishlistModal" class="modal fade modal-close-inside" tabindex="-1" role="dialog"><div class="modal-dialog" role="document"><div class="modal-content"><div class="modal-header"><h1 class="jxwl-title modal-title"><span class="jxwl-step-1">' + wishlist_title_step_1 + '<span>' + wishlist_title_step_1_desc + '</span></span><span class="jxwl-step-2">' + wishlist_title_step_2 + '<span>' + wishlist_title_step_2_desc + '</span></span></h1><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="linearicons-cross" aria-hidden="true"></span></button></div><div class="modal-body"><ul id="jxwl-layouts-popup" class="bootstrap clearfix">' + jxwl_lp_content + '<input id="id_wishlist_popup" type="hidden" name="id_wishlist" value="" /><input id="name_wishlist_popup" type="hidden" name="name_wishlist" value="" /></ul></div></div></div></div>');
  $('#wishlistModal').modal();
  $('[id^="quickview-modal-"]').modal('hide');
  $('#wishlistModal').on('hidden.bs.modal', function(e) {
    $('#wishlistModal').remove();
  });
  $('.jxwl_popup_item h5').append(wishlist_name);
  return false;
}

function getProductsByWishlistId(id_wishlist) {
  let result = '';
  $.ajax({
    type: 'POST',
    url: mywishlists_url,
    headers: {"cache-control": "no-cache"},
    dataType: 'json',
    async: false,
    data: {
      rand: new Date().getTime(),
      myajax: 1,
      id_wishlist: id_wishlist,
      action: 'getProductsById',
    },
    success: function(msg) {
      result = msg.response;
    }
  });
  return result;
}

function addNewRow(layout_type) {
  let layout = '';
  var id_wishlist = $('#id_wishlist_popup[name=id_wishlist]').attr('value');
  switch (layout_type) {
    case 'jxwl_row_1' :
      layout = jxwl_row_1;
      break;
    case 'jxwl_row_2' :
      layout = jxwl_row_2;
      break;
    case 'jxwl_row_3' :
      layout = jxwl_row_3;
      break;
    case 'jxwl_row_4' :
      layout = jxwl_row_4;
      break;
    default :
      layout = layout;
  }
  let jxwl_new_row = '';
  jxwl_new_row += '<ul class="block-container-row">';
  jxwl_new_row += layout;
  jxwl_new_row += '<input id="popup_selected_products" type="hidden" name="selected_products" value="" />';
  jxwl_new_row += '<div class="block-container-product clearfix">' + getProductsByWishlistId(id_wishlist) + '</div><button id="back_button_step_2"  type="button" class="btn back_button btn-default">' + back_btn_text + '</button>';
  jxwl_new_row += '<button id="back_button"  type="button" class="btn btn-default back_button"><i class="fa fa-angle-left" aria-hidden="true"></i>&nbsp;<span>';
  jxwl_new_row += '' + back_btn_text + '';
  jxwl_new_row += '</span></button>';
  jxwl_new_row += '<button id="share_button_' + id_wishlist + '" type="button" class="btn btn-default share_button">';
  jxwl_new_row += '<span>' + share_btn_text + '</span>';
  jxwl_new_row += '</button>';
  jxwl_new_row += '</ul';
  $('#jxwl-layouts-popup').append(jxwl_new_row);
  $('.block-container-product').hide();
  return false;
}

function WishlistEdit(id_wishlist) {
  if (typeof mywishlists_url === 'undefined') {
    return false;
  }
  $.ajax({
    type: 'GET',
    async: true,
    dataType: "json",
    url: mywishlists_url,
    headers: {"cache-control": "no-cache"},
    cache: false,
    data: {
      rand: new Date().getTime(),
      edit: 1,
      myajax: 1,
      id_wishlist: id_wishlist,
      action: 'editlist'
    },
    success: function(msg) {
      var name_wishlist = msg.name_wishlist,
        id_wishlist = msg.id_wishlist;
      $('#name_wishlist').val(name_wishlist);
      $('#id_wishlist').val(id_wishlist);
      $("#submitWishlists span").text(change_name_wishlist);
      $("#submitWishlists").attr("name", "changeWishlist");
    }
  });
}

window.WishlistEdit = WishlistEdit;

function WishlistDelete(id, id_wishlist, msg) {
  var res = confirm(msg);
  if (res == false) {
    return false;
  }
  if (typeof mywishlists_url == 'undefined') {
    return false;
  }
  $.ajax({
    type: 'GET',
    async: true,
    dataType: "json",
    url: mywishlists_url,
    headers: {"cache-control": "no-cache"},
    cache: false,
    data: {
      rand: new Date().getTime(),
      deleted: 1,
      myajax: 1,
      id_wishlist: id_wishlist,
      action: 'deletelist'
    },
    success: function(data) {
      var mywishlists_siblings_count = $('#' + id).siblings().length;
      $('#' + id).fadeOut('slow').remove();
      $("#block-order-detail").html('');
      if (mywishlists_siblings_count == 0) {
        $("#block-history").remove();
      }
    }
  });
}

window.WishlistDelete = WishlistDelete;

function AddProductToWishlist(event, action_add, id_product, product_name, id_product_attribute, quantity, id_wishlist) {
  if (typeof mywishlists_url === 'undefined') {
    return false;
  }
  $.ajax({
    type: 'GET',
    async: true,
    dataType: "json",
    url: mywishlists_url,
    headers: {"cache-control": "no-cache"},
    cache: false,
    data: {
      rand: new Date().getTime(),
      add: 1,
      myajax: 1,
      action_add: action_add,
      id_product: id_product,
      id_product_attribute: id_product_attribute,
      quantity: quantity,
      id_wishlist: id_wishlist,
      action: 'addproduct'
    },
    success: function(data) {
      if (action_add == 'action_add') {
        if (isLogged == true) {
          $('body').append('<div id="wishlistAddedModal" class="modal fade modal-close-inside" tabindex="-1" role="dialog"><div class="modal-dialog modal-sm" role="document"><div class="modal-content"><div class="modal-header"><h4 class="jxwl-title modal-title">' + product_name + '</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="linearicons-cross" aria-hidden="true"></span></button></div><div class="modal-body"><div class="clearfix"><p class="clearfix">' + added_to_wishlist + '</p><a class="pop_btn_wishlist link" href="' + mywishlists_url + '" title="' + btn_wishlist + '"> <span>' + btn_wishlist + '</span></a></div></div></div></div></div>');
          $('[data-id-product="' + id_product + '"]').find('.wishlist-btn').addClass('added-to-wishlist');
          $(event.target).closest('.wishlist-btn').addClass('added-to-wishlist');
        } else {
          $('body').append('<div id="wishlistAddedModal" class="modal fade modal-close-inside" tabindex="-1" role="dialog"><div class="modal-dialog modal-sm" role="document"><div class="modal-content"><div class="modal-header"><h4 class="jxwl-title modal-title">' + product_name + '</h4><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="linearicons-cross" aria-hidden="true"></span></button></div><div class="modal-body"><p>' + loggin_wishlist_required + '</p></div></div></div></div>');
        }
        $('#wishlistAddedModal').modal();
        $('[id^="quickview-modal-"]').modal('hide');
        $('#wishlistAddedModal').on('hidden.bs.modal', function(e) {
          $(this).remove();
        });
      }
    }
  });
}

window.AddProductToWishlist = AddProductToWishlist;

function DeleteProduct(id_wishlist, id_product, id_product_attribute) {
  $.ajax({
    type: 'GET',
    async: true,
    dataType: "json",
    url: mywishlists_url,
    headers: {"cache-control": "no-cache"},
    cache: false,
    data: {
      myajax: 1,
      action: 'deleteproduct',
      id_wishlist: id_wishlist,
      id_product: id_product,
      id_product_attribute: id_product_attribute,
    },
    success: function(data) {
      $('#wishlist_' + id_wishlist + ' .clp_' + id_product + '_' + id_product_attribute).hide();
      $('#clp_' + id_product + '_' + id_product_attribute).hide();
    }
  });
}

window.DeleteProduct = DeleteProduct;