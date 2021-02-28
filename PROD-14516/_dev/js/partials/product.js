/**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */
import $ from "jquery";

$(document).ready(function () {
  if ($('body#product').length) {
    var productPageContainer = $('body#product #main');
    createProductSpin(productPageContainer);
    createInputFile(productPageContainer);
    createCoverImage(productPageContainer);
    createProductZoom();
    $(window).load(function() {
      createProductThumbnails(productPageContainer);
    });
  }

  prestashop.on('clickQuickView', function (elm) {
    $('body').append($('#quickview-template-'+ elm.dataset.idProduct +'-'+ elm.dataset.idProductAttribute +'').html());
    $('#quickview-modal-'+ elm.dataset.idProduct +'-'+ elm.dataset.idProductAttribute +'').modal('show').on('shown.bs.modal', function (e) {
      createProductThumbnails($(e.currentTarget));
      createCoverImage($(e.currentTarget));
      createProductSpin($(e.currentTarget));
      createProductZoom();
      $('#product #main').find('.product-refresh').attr('class', 'product-refresh-hidden').attr('name', 'refresh-hidden');
    }).on('hidden.bs.modal', function (e) {
      $('#product #main').find('.product-refresh-hidden').attr('class', 'product-refresh').attr('name', 'refresh').click();
      e.currentTarget.remove();
    });

    let data = {
      'action': 'quickview',
      'id_product': elm.dataset.idProduct,
      'id_product_attribute': elm.dataset.idProductAttribute
    };

    $.post(prestashop.urls.pages.product, data, null, 'json').then(function (resp) {
      $(`#quickview-modal-${resp.product.id}-${resp.product.id_product_attribute}`).append(resp.quickview_html).find('.modal-dialog [id*="quickview-"]').each(function (index, value) {
        $(value).replaceWith($('#quickview-resp #'+ value.id +''));
        if (value.id == 'quickview-product-addToCart') {
          createProductSpin($(`#quickview-modal-${resp.product.id}-${resp.product.id_product_attribute}`));
        }
      });
    }).fail((resp) => {
      prestashop.emit('handleError', {eventType: 'clickQuickView', resp: resp});
    });
  });

  prestashop.on('updatedProduct', function (event) {
    if (event && event.product_minimal_quantity) {
      const minimalProductQuantity = parseInt(event.product_minimal_quantity, 10);
      const quantityInputSelector = '#quantity_wanted';
      let quantityInput = $(quantityInputSelector);
      quantityInput.trigger('touchspin.updatesettings', {min: minimalProductQuantity});
    }

    let quickviewContainer = $('[id*="quickview-modal-"]');
    if (quickviewContainer.length) {
      createProductThumbnails(quickviewContainer);
      createCoverImage(quickviewContainer);
      $('#main').find('.product-card').css('opacity', 0.2);
    } else {
      createProductThumbnails(productPageContainer);
      createCoverImage(productPageContainer);
      $('#main').find('.product-card').css('opacity', 1);
    }
    $($('.tabs .nav-link.active').attr('href')).addClass('active').removeClass('fade');
  });

  function createCoverImage(data) {
    $(data.find('.js-thumb')).on(
      'click',
      (event) => {
        $(data.find('.selected')).removeClass('selected');
        $(event.target).addClass('selected');
        $(data.find('.js-qv-product-cover')).prop('src', $(event.currentTarget).data('image-large-src'));
      }
    );
  }

  function createInputFile() {
    $('.js-file-input').on('change', (event) => {
      let target, file;
      if ((target = $(event.currentTarget)[0]) && (file = target.files[0])) {
        $(target).prev().text(file.name);
      }
    });
  }

  function createProductZoom() {
    $('body').on('click', '.layer', function (e) {
      $('body')
        .append('<div id="product-modal" class="modal fade modal-close-inside" tabindex="-1" role="dialog" aria-hidden="true"><div class="modal-dialog" role="document"><button type="button" class="close linearicons-cross" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button><div class="modal-content"></div></div></div>')
        .find('#product-modal')
        .modal('show')
        .on('shown.bs.modal', function (e) {
          createProductThumbnails($(e.currentTarget));
          createCoverImage($(e.currentTarget));
          $(e.currentTarget).css('opacity', 1);
        })
        .on('hidden.bs.modal', function () {
          $('#product-modal').remove();
          if ($('[id*="quickview-modal-"]').length) {
            $('body').addClass('modal-open');
          }
        })
        .find('.modal-content').html($(e.target).closest('.images-container').clone()).find('.layer, .zoomContainer').remove();
    });
  }

  function createProductSpin(data) {
    let quantityInput = $(data.find('#quantity_wanted'));
    quantityInput.TouchSpin({
      verticalbuttons: true,
      verticalupclass: 'fa fa-angle-up',
      verticaldownclass: 'fa fa-angle-down',
      buttondown_class: 'btn',
      buttonup_class: 'btn',
      min: parseInt(quantityInput.attr('min'), 10),
      max: 1000000
    });

    quantityInput.on('change', function (event) {
      let $productRefresh = $(data.find('.product-refresh'));
      $(event.currentTarget).trigger('touchspin.stopspin');
      $productRefresh.trigger('click', {eventType: 'updatedProductQuantity'});
      event.preventDefault();

      return false;
    });
  }

  function createProductThumbnails(data) {
    var productThumbnailsSwiper = new Swiper(data.find('.products-swiper-container:visible'), {
      direction: 'vertical',  //vertical thumbs
      slidesPerView: 3,
      spaceBetween: 20,
      navigation: {
        nextEl: '.product-images-next',
        prevEl: '.product-images-prev'
      },
      preloadImages: false,
      breakpoints: {
        991: {
          spaceBetween: 10
        }
      },
      on: {
        init: function () {
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          }
        },
        resize: function () {
          this.update();
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          } else {
            this.allowTouchMove = true;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).show();
          }
        }
      }
    });
    productThumbnailsSwiper.update();
    data.find('.product-images').css('opacity', 1);
  }
});