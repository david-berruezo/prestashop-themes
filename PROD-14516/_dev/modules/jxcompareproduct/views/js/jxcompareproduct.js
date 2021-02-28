/**
 * 2002-2018 Zemez
 *
 * JX Compare Product
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

$(document).ready(function() {
  prestashop.jxcompare = prestashop.jxcompare || {};
  var noComparingPreview = true;
  var $body = $('body');
  var $container = $body.find('#compare-footer');
  var $compareCounter = $body.find('.compare-counter');
  var $containerList = $body.find('#compare-list-footer');
  var $header_info = $body.find('.compare-header');
  var refresh_url = $body.find('#compare-footer').attr('data-refresh-url');
  if (refresh_url === undefined) {
    refresh_url = $header_info.attr('data-refresh-url');
  }
  var $compareMax = $container.attr('data-compare-max');
  if ($compareMax === undefined) {
    $compareMax = $header_info.attr('data-compare-max');
  }
  prestashop.urls.jxcompare = refresh_url;
  var setProducts = function() {
    if (localStorage.compareProducts) {
      var available = localStorage.compareProducts.split(',');
      if (available.length) {
        prestashop.jxcompare.products = available;
        $compareCounter.text(available.length);
      }
    } else {
      $compareCounter.text(0);
      prestashop.jxcompare.products = [];
    }
  };
  setProducts();
  var checkProductStatus = function() {
    $body.find('.js-compare-button').each(function() {
      var id_product = $(this).attr('data-id-product');
      if (prestashop.jxcompare.products.indexOf(id_product) !== -1) {
        $(this).addClass('selected');
      } else {
        $(this).removeClass('selected');
      }
    });
  };
  checkProductStatus();
  var showModal = prestashop.jxcompare.showModal || function(modal) {
    $.ajax({
      type: 'GET',
      async: true,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      url: refresh_url,
      cache: false,
      data: {
        rand: new Date().getTime(),
        action: 'show-modal',
        products: prestashop.jxcompare.products
      },
      beforeSend: function() {
        $('.modal-compare').remove();
      },
      success: function(data) {
        $body.append(data.response);
        $('#modal-compare').modal('show');
        $('#modal-compare').on('hidden.bs.modal', function(e) {
          $('#modal-compare').remove();
        });
      }
    });
  };
  var clearCompare = prestashop.jxcompare.clearCompare || function() {
    prestashop.jxcompare.products = [];
    localStorage.setItem('compareProducts', '');
    $containerList.find('.compare-product-element').each(function() {
      $(this).remove()
    });
    $compareCounter.text(0);
    $containerList.find('.no-products').remove();
    $containerList.append('<li class="no-products list-inline-item">' + $container.attr('data-empty-text') + '</li>');
    $body.find('.js-compare-button').each(function() {
      $(this).removeClass('selected');
    });
  };
  var showPreview = prestashop.jxcompare.showPreview || function() {
    $container.addClass('loading');
    $.ajax({
      type: 'GET',
      async: true,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      url: refresh_url,
      cache: false,
      data: {
        rand: new Date().getTime(),
        action: 'refresh-preview',
        products: prestashop.jxcompare.products
      },
      success: function(data) {
        $containerList.find('.compare-product-element').each(function() {
          $(this).remove()
        });
        $containerList.find('.no-products').remove();
        $(data.response).appendTo($containerList);
        $container.removeClass('loading');
      }
    });
  };
  $(document).on('click', '.js-compare-button', function(event) {
    event.preventDefault();
    event.stopPropagation();
    var action = event.currentTarget.dataset.action;
    var idProduct = event.currentTarget.dataset.idProduct;
    var products = prestashop.jxcompare.products;
    if ($(this).hasClass('selected') || action === 'remove-product') {
      removeProduct(idProduct);
    } else {
      addProduct(idProduct);
    }
    checkProductStatus();
  });
  $(document).on('click', '.compare-footer-grover', function() {
    $(this).parent().toggleClass('visible-compare-footer');
    showPreview();
  });
  $(document).on('click', '.compare-products', function(event) {
    event.preventDefault();
    showModal();
  });
  $(document).on('click', '.compare-clear', function(event) {
    event.preventDefault();
    clearCompare();
  });
  $(document).on('click', '#compare-features .features-toggle', function() {
    $('#compare-features').toggleClass('close-titles');
    $('#compare-products').toggleClass('close-titles');
  });
  var addProduct = function(id) {
    var products = prestashop.jxcompare.products;
    if (products.length > $compareMax - 1) {
      return prestashop.emit('compareMaxError');
    }
    if (products.indexOf(id) === -1) {
      products.push(id);
    }
    localStorage.setItem('compareProducts', products);
    $.ajax({
      type: 'GET',
      async: true,
      dataType: "json",
      headers: {"cache-control": "no-cache"},
      url: refresh_url,
      cache: false,
      data: {
        rand: new Date().getTime(),
        action: 'add-product-to-preview',
        id_product: id
      },
      success: function(data) {
        $(data.response).appendTo($containerList);
        $container.removeClass('.loading').find('.no-products').remove();
      }
    });
    setProducts();
  };
  var removeProduct = function(id) {
    var products = prestashop.jxcompare.products;
    var position = products.indexOf(id);
    if (position > -1) {
      products.splice(position, 1);
    }
    localStorage.setItem('compareProducts', products);
    $body.find('.compare-product-element[data-id-product="' + id + '"]').remove();
    if ($container.find('.compare-product-element').length < 1) {
      $containerList.append('<li class="no-products">' + $container.attr('data-empty-text') + '</li>');
      $('#modal-compare').removeClass('with-products').find('.modal-lg').removeClass('modal-lg').addClass('modal-sm').find('.modal-content-compare').append('<div class="modal-body"><p class="no-products mb-0">' + $container.attr('data-empty-text') + '</p></div>');
    }
    setProducts();
  };
  prestashop.on('compareMaxError', function() {
    var message = $container.attr('data-max-alert-message');
    if (message === undefined) {
      message = $header_info.attr('data-max-alert-message');
    }
    $body.append('<div id="modal-compare-alert" class="modal fade modal-close-inside" tabindex="-1" role="dialog"><div class="modal-dialog modal-sm" role="document"><div class="modal-content"><button type="button" class="close linearicons-cross" data-dismiss="modal" aria-label="Close"></button><div class="modal-body">' + message + '</div></div></div></div>');
    $('#modal-compare-alert').modal('show');
    $('#modal-compare-alert').on('hidden.bs.modal', function(e) {
      $('#modal-compare-alert').remove();
    });
  });
});