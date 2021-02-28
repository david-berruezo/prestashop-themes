!function(t){var n={};function i(e){if(n[e])return n[e].exports;var s=n[e]={i:e,l:!1,exports:{}};return t[e].call(s.exports,s,s.exports,i),s.l=!0,s.exports}i.m=t,i.c=n,i.d=function(t,n,e){i.o(t,n)||Object.defineProperty(t,n,{enumerable:!0,get:e})},i.r=function(t){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(t,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(t,"__esModule",{value:!0})},i.t=function(t,n){if(1&n&&(t=i(t)),8&n)return t;if(4&n&&"object"==typeof t&&t&&t.__esModule)return t;var e=Object.create(null);if(i.r(e),Object.defineProperty(e,"default",{enumerable:!0,value:t}),2&n&&"string"!=typeof t)for(var s in t)i.d(e,s,function(n){return t[n]}.bind(null,s));return e},i.n=function(t){var n=t&&t.__esModule?function(){return t.default}:function(){return t};return i.d(n,"a",n),n},i.o=function(t,n){return Object.prototype.hasOwnProperty.call(t,n)},i.p="",i(i.s=75)}({75:function(module,exports,__webpack_require__){"use strict";eval("\n\n/*\r\n * 2002-2018 Zemez\r\n *\r\n * JX Wishlist\r\n *\r\n * NOTICE OF LICENSE\r\n *\r\n * This source file is subject to the General Public License (GPL 2.0)\r\n * that is bundled with this package in the file LICENSE.txt.\r\n * It is also available through the world-wide-web at this URL:\r\n * http://opensource.org/licenses/GPL-2.0\r\n *\r\n * DISCLAIMER\r\n *\r\n * Do not edit or add to this file if you wish to upgrade the module to newer\r\n * versions in the future.\r\n *\r\n *  @author    Zemez\r\n *  @copyright 2002-2018 Zemez\r\n *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)\r\n */\nvar jxwishlist = {\n  list: function list() {\n    this.init = function (json) {\n      if (json == '') {\n        json = '[]';\n      }\n      this.array = JSON.parse(json);\n    };\n    this.extend = function (json) {\n      var products = JSON.parse(json);\n      for (var i = 0; i < products.length; i++) {\n        this.array[this.array.length] = products[i];\n      }\n      return JSON.stringify(this.array);\n    };\n    this.add = function (elem) {\n      if (this.array.indexOf(elem) == -1) {\n        this.array[this.array.length] = elem;\n      }\n      return JSON.stringify(this.array);\n    };\n    this.remove = function (elem) {\n      var index = this.array.indexOf(elem);\n      this.array.splice(index, 1);\n      return JSON.stringify(this.array);\n    };\n  }\n};\n$(document).ready(function () {\n  $(':input', '#form_wishlist').not(':button, :submit, :reset, :hidden').val('').removeAttr('checked').removeAttr('selected');\n  $(\".edit-wishlist\").click(function () {\n    $('html, body').animate({ scrollTop: 0 }, 800);\n    return false;\n  });\n  $('.btn-product-wishlist').click(function () {\n    $(this).parent().prev().fadeToggle(\"slow\", \"linear\");\n    $(this).addClass('active');\n  });\n  $(\"#change_wishlist\").hide();\n  window.jxwl_layouts = new Array();\n  $(document).on('click', '#add-new-layout', function () {\n    var wishlist_name = $(this).parent().parent().attr('data-wishlist-name');\n    layouts_popup(wishlist_name);\n    var wishlist_id = $(this).parent().parent().attr('data-wishlist-id');\n    $('#id_wishlist_popup').attr('value', wishlist_id);\n    $('#name_wishlist_popup').attr('value', wishlist_name);\n    $('.jxwl-step-2').hide();\n  });\n  $(document).on('click', '#back_button', function () {\n    $('.block-container-row').remove();\n    $('#jxwl-layouts-popup > .jxwl_popup_item, .jxwl-step-1').show();\n    $('.jxwl-step-2').hide();\n  });\n  $(document).on('click', '#jxwl-layouts-popup > .jxwl_popup_item > .items', function () {\n    var layout_type = $(this).attr('id');\n    addNewRow(layout_type);\n    $('#jxwl-layouts-popup > .jxwl_popup_item, .jxwl-step-1').hide();\n    $('.jxwl-step-2').show();\n    $(\"#back_button_step_2\").hide();\n  });\n  $(document).on('click', '.block-container-row .jxwl_popup_item li', function () {\n    $(this).addClass('active');\n    $('.block-container-row .jxwl_popup_item, .block-container-row .share_button, .block-container-row #back_button').hide();\n    $('.block-container-product, .block-container-row .alert-warning, #clear-item').show();\n    if ($('.block-container-product > div.done').length <= 0) {\n      $('.block-container-row .block-container-product').append('<p class=\"alert alert-warning\">' + wishlist_no_product + '</p>');\n    }\n    $(\"#back_button_step_2\").show();\n  });\n  $(document).on('click', '.block-container-row .jxwl_popup_item li .jxwl-content-image', function () {\n    $('.block-container-product .alert').hide();\n    var products = new jxwishlist.list();\n    var data_product_id = $(this).attr('data-product-id');\n    products.init($('#popup_selected_products').attr('value'));\n    $('#popup_selected_products').attr('value', products.remove(data_product_id));\n    $('.block-container-product .product').filter('[data-product-id=\"' + data_product_id + '\"]').removeClass('active');\n    $('.block-container-product .product').filter('[data-product-id=\"' + data_product_id + '\"]').addClass('done');\n  });\n  $(document).on('click', '.block-container-product .product', function (e) {\n    var image_src = $(this).find('img').attr('src');\n    var current_block = $('.block-container-row .jxwl_popup_item li.active .content');\n    current_block.find('.content-inner').remove();\n    current_block.append('<div class=\"content-inner\"><div class=\"jxwl-content-image\"><span class=\"icon-remove linearicons-cross clear-item\" aria-hidden=\"true\"></span><img class=\"img-fluid\" src=\"' + image_src + '\" alt=\"\" /></div></div>');\n    current_block.addClass('current');\n    $('.block-container-row .jxwl_popup_item li.active .content .jxwl-content-image').attr('data-product-id', $(this).attr(\"data-product-id\"));\n    $(this).addClass('active');\n    $(this).removeClass('done');\n    $('.block-container-row .share_button').show();\n    var products = new jxwishlist.list();\n    products.init($('#popup_selected_products').attr('value'));\n    var product_id = $(this).attr('data-product-id');\n    $('#popup_selected_products').attr('value', products.add(product_id));\n    $('.block-container-product, #back_button_step_2').hide();\n    $('.block-container-row .jxwl_popup_item, .block-container-row #share_button, .block-container-row #back_button').show();\n    $('.block-container-row .jxwl_popup_item li').removeClass('active');\n  });\n  $(document).on('click', '#back_button_step_2', function () {\n    $('.block-container-row .share_button, .block-container-row .jxwl_popup_item, #back_button').show();\n    $('.block-container-product, #back_button_step_2').hide();\n    $('.block-container-row .jxwl_popup_item li').removeClass('active');\n    $('.block-container-product .alert').remove();\n    var products = new jxwishlist.list();\n    products.init($('#popup_selected_products').attr('value'));\n    if (typeof data_product_id != 'undefined' && data_product_id.length) {\n      $('#popup_selected_products').attr('value', products.add(data_product_id));\n      $('.block-container-product .product').filter('[data-product-id=\"' + data_product_id + '\"]').removeClass('done');\n      $('.block-container-product .product').filter('[data-product-id=\"' + data_product_id + '\"]').addClass('active');\n    }\n  });\n  $(document).on('click', '.clear-item', function (e) {\n    e.stopPropagation();\n    $(this).parent().parent().parent().removeClass('current');\n    var products = new jxwishlist.list(),\n        product_id = $(this).parent().attr('data-product-id');\n    products.init($('#popup_selected_products').attr('value'));\n    $('#popup_selected_products').attr('value', products.remove(product_id));\n    $('.block-container-product .product').filter('[data-product-id=\"' + product_id + '\"]').removeClass('active');\n    $('.block-container-product .product').filter('[data-product-id=\"' + product_id + '\"]').addClass('done');\n    var element = $(this).closest('li');\n    $(this).remove();\n    element.find('.content-inner').remove();\n  });\n});\n\nfunction layouts_popup(wishlist_name) {\n  var jxwl_lp_content = '';\n  if (jxwl_layouts.length) {\n    for (var i = 0; i < jxwl_layouts.length; i++) {\n      jxwl_lp_content += jxwl_layouts[i].value;\n    }\n  }\n  $('body').append('<div id=\"wishlistModal\" class=\"modal fade modal-close-inside\" tabindex=\"-1\" role=\"dialog\"><div class=\"modal-dialog\" role=\"document\"><div class=\"modal-content\"><div class=\"modal-header\"><h1 class=\"jxwl-title modal-title\"><span class=\"jxwl-step-1\">' + wishlist_title_step_1 + '<span>' + wishlist_title_step_1_desc + '</span></span><span class=\"jxwl-step-2\">' + wishlist_title_step_2 + '<span>' + wishlist_title_step_2_desc + '</span></span></h1><button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span class=\"linearicons-cross\" aria-hidden=\"true\"></span></button></div><div class=\"modal-body\"><ul id=\"jxwl-layouts-popup\" class=\"bootstrap clearfix\">' + jxwl_lp_content + '<input id=\"id_wishlist_popup\" type=\"hidden\" name=\"id_wishlist\" value=\"\" /><input id=\"name_wishlist_popup\" type=\"hidden\" name=\"name_wishlist\" value=\"\" /></ul></div></div></div></div>');\n  $('#wishlistModal').modal();\n  $('[id^=\"quickview-modal-\"]').modal('hide');\n  $('#wishlistModal').on('hidden.bs.modal', function (e) {\n    $('#wishlistModal').remove();\n  });\n  $('.jxwl_popup_item h5').append(wishlist_name);\n  return false;\n}\n\nfunction getProductsByWishlistId(id_wishlist) {\n  var result = '';\n  $.ajax({\n    type: 'POST',\n    url: mywishlists_url,\n    headers: { \"cache-control\": \"no-cache\" },\n    dataType: 'json',\n    async: false,\n    data: {\n      rand: new Date().getTime(),\n      myajax: 1,\n      id_wishlist: id_wishlist,\n      action: 'getProductsById'\n    },\n    success: function success(msg) {\n      result = msg.response;\n    }\n  });\n  return result;\n}\n\nfunction addNewRow(layout_type) {\n  var layout = '';\n  var id_wishlist = $('#id_wishlist_popup[name=id_wishlist]').attr('value');\n  switch (layout_type) {\n    case 'jxwl_row_1':\n      layout = jxwl_row_1;\n      break;\n    case 'jxwl_row_2':\n      layout = jxwl_row_2;\n      break;\n    case 'jxwl_row_3':\n      layout = jxwl_row_3;\n      break;\n    case 'jxwl_row_4':\n      layout = jxwl_row_4;\n      break;\n    default:\n      layout = layout;\n  }\n  var jxwl_new_row = '';\n  jxwl_new_row += '<ul class=\"block-container-row\">';\n  jxwl_new_row += layout;\n  jxwl_new_row += '<input id=\"popup_selected_products\" type=\"hidden\" name=\"selected_products\" value=\"\" />';\n  jxwl_new_row += '<div class=\"block-container-product clearfix\">' + getProductsByWishlistId(id_wishlist) + '</div><button id=\"back_button_step_2\"  type=\"button\" class=\"btn back_button btn-default\">' + back_btn_text + '</button>';\n  jxwl_new_row += '<button id=\"back_button\"  type=\"button\" class=\"btn btn-default back_button\"><i class=\"fa fa-angle-left\" aria-hidden=\"true\"></i>&nbsp;<span>';\n  jxwl_new_row += '' + back_btn_text + '';\n  jxwl_new_row += '</span></button>';\n  jxwl_new_row += '<button id=\"share_button_' + id_wishlist + '\" type=\"button\" class=\"btn btn-default share_button\">';\n  jxwl_new_row += '<span>' + share_btn_text + '</span>';\n  jxwl_new_row += '</button>';\n  jxwl_new_row += '</ul';\n  $('#jxwl-layouts-popup').append(jxwl_new_row);\n  $('.block-container-product').hide();\n  return false;\n}\n\nfunction WishlistEdit(id_wishlist) {\n  if (typeof mywishlists_url === 'undefined') {\n    return false;\n  }\n  $.ajax({\n    type: 'GET',\n    async: true,\n    dataType: \"json\",\n    url: mywishlists_url,\n    headers: { \"cache-control\": \"no-cache\" },\n    cache: false,\n    data: {\n      rand: new Date().getTime(),\n      edit: 1,\n      myajax: 1,\n      id_wishlist: id_wishlist,\n      action: 'editlist'\n    },\n    success: function success(msg) {\n      var name_wishlist = msg.name_wishlist,\n          id_wishlist = msg.id_wishlist;\n      $('#name_wishlist').val(name_wishlist);\n      $('#id_wishlist').val(id_wishlist);\n      $(\"#submitWishlists span\").text(change_name_wishlist);\n      $(\"#submitWishlists\").attr(\"name\", \"changeWishlist\");\n    }\n  });\n}\n\nwindow.WishlistEdit = WishlistEdit;\n\nfunction WishlistDelete(id, id_wishlist, msg) {\n  var res = confirm(msg);\n  if (res == false) {\n    return false;\n  }\n  if (typeof mywishlists_url == 'undefined') {\n    return false;\n  }\n  $.ajax({\n    type: 'GET',\n    async: true,\n    dataType: \"json\",\n    url: mywishlists_url,\n    headers: { \"cache-control\": \"no-cache\" },\n    cache: false,\n    data: {\n      rand: new Date().getTime(),\n      deleted: 1,\n      myajax: 1,\n      id_wishlist: id_wishlist,\n      action: 'deletelist'\n    },\n    success: function success(data) {\n      var mywishlists_siblings_count = $('#' + id).siblings().length;\n      $('#' + id).fadeOut('slow').remove();\n      $(\"#block-order-detail\").html('');\n      if (mywishlists_siblings_count == 0) {\n        $(\"#block-history\").remove();\n      }\n    }\n  });\n}\n\nwindow.WishlistDelete = WishlistDelete;\n\nfunction AddProductToWishlist(event, action_add, id_product, product_name, id_product_attribute, quantity, id_wishlist) {\n  if (typeof mywishlists_url === 'undefined') {\n    return false;\n  }\n  $.ajax({\n    type: 'GET',\n    async: true,\n    dataType: \"json\",\n    url: mywishlists_url,\n    headers: { \"cache-control\": \"no-cache\" },\n    cache: false,\n    data: {\n      rand: new Date().getTime(),\n      add: 1,\n      myajax: 1,\n      action_add: action_add,\n      id_product: id_product,\n      id_product_attribute: id_product_attribute,\n      quantity: quantity,\n      id_wishlist: id_wishlist,\n      action: 'addproduct'\n    },\n    success: function success(data) {\n      if (action_add == 'action_add') {\n        if (isLogged == true) {\n          $('body').append('<div id=\"wishlistAddedModal\" class=\"modal fade modal-close-inside\" tabindex=\"-1\" role=\"dialog\"><div class=\"modal-dialog modal-sm\" role=\"document\"><div class=\"modal-content\"><div class=\"modal-header\"><h4 class=\"jxwl-title modal-title\">' + product_name + '</h4><button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span class=\"linearicons-cross\" aria-hidden=\"true\"></span></button></div><div class=\"modal-body\"><div class=\"clearfix\"><p class=\"clearfix\">' + added_to_wishlist + '</p><a class=\"pop_btn_wishlist link\" href=\"' + mywishlists_url + '\" title=\"' + btn_wishlist + '\"> <span>' + btn_wishlist + '</span></a></div></div></div></div></div>');\n          $('[data-id-product=\"' + id_product + '\"]').find('.wishlist-btn').addClass('added-to-wishlist');\n          $(event.target).closest('.wishlist-btn').addClass('added-to-wishlist');\n        } else {\n          $('body').append('<div id=\"wishlistAddedModal\" class=\"modal fade modal-close-inside\" tabindex=\"-1\" role=\"dialog\"><div class=\"modal-dialog modal-sm\" role=\"document\"><div class=\"modal-content\"><div class=\"modal-header\"><h4 class=\"jxwl-title modal-title\">' + product_name + '</h4><button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span class=\"linearicons-cross\" aria-hidden=\"true\"></span></button></div><div class=\"modal-body\"><p>' + loggin_wishlist_required + '</p></div></div></div></div>');\n        }\n        $('#wishlistAddedModal').modal();\n        $('[id^=\"quickview-modal-\"]').modal('hide');\n        $('#wishlistAddedModal').on('hidden.bs.modal', function (e) {\n          $(this).remove();\n        });\n      }\n    }\n  });\n}\n\nwindow.AddProductToWishlist = AddProductToWishlist;\n\nfunction DeleteProduct(id_wishlist, id_product, id_product_attribute) {\n  $.ajax({\n    type: 'GET',\n    async: true,\n    dataType: \"json\",\n    url: mywishlists_url,\n    headers: { \"cache-control\": \"no-cache\" },\n    cache: false,\n    data: {\n      myajax: 1,\n      action: 'deleteproduct',\n      id_wishlist: id_wishlist,\n      id_product: id_product,\n      id_product_attribute: id_product_attribute\n    },\n    success: function success(data) {\n      $('#wishlist_' + id_wishlist + ' .clp_' + id_product + '_' + id_product_attribute).hide();\n      $('#clp_' + id_product + '_' + id_product_attribute).hide();\n    }\n  });\n}\n\nwindow.DeleteProduct = DeleteProduct;\n\n//# sourceURL=webpack:///./modules/jxwishlist/views/js/ajax-wishlists.js?")}});