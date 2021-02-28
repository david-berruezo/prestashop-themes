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

// Init ProductCommons with six parameters:
// 1) Create Cover Image, 2) Create Input File,
// 3) Create Product Spin, 4) Create Image Slider,
// 5) Create Gallery(example: '5 4 3'), 6) Create Vertical Gallery(example: '5-4-3')
import ProductCommons from './components/product-commons';

$(document).ready(function () {
  prestashop.on('clickQuickView', function (elm) {
    let data = {
      'action': 'quickview',
      'id_product': elm.dataset.idProduct,
      'id_product_attribute': elm.dataset.idProductAttribute,
    };
    $.post(prestashop.urls.pages.product, data, null, 'json').then(function (resp) {
      $('body').append(resp.quickview_html);
      $(`#quickview-modal-${resp.product.id}-${resp.product.id_product_attribute}`)
        .modal('show')
        .on('shown.bs.modal', function () {
          let productQuickView = new ProductCommons($('#quickview-product-card'));
          productQuickView.init(true, false, true, true, false, false, '3-3-3');

          prestashop.on('updatedProduct', function (event) {
            const $newImagesContainer = $('<div>').append(event.product_images_modal);
            $('#quickview-product-card .quickview-images-container').replaceWith($newImagesContainer.find('.quickview-images-container'));
            $('#product-modal').replaceWith($newImagesContainer.find('#product-modal'));

            if (event && event.product_minimal_quantity) {
              const minimalProductQuantity = parseInt(event.product_minimal_quantity, 10);
              const quantityInputSelector = '#quickview-product-card #quantity_wanted';
              let quantityInput = $(quantityInputSelector);
              quantityInput.trigger('touchspin.updatesettings', {min: minimalProductQuantity});
            }

            productQuickView.init(true, false, true, true, false, false, '3-3-3');
          });
        }).on('hidden.bs.modal', function () {
        $('[id*="quickview-modal-"], #product-modal').remove();
      });
    }).fail((resp) => {
      prestashop.emit('handleError', {eventType: 'clickQuickView', resp: resp});
    });
  });
});
