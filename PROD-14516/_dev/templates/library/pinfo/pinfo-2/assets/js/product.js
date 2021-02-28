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

import ProductCommons from "../../../../../../js/components/product-commons";

$(document).ready(function () {
  let productCard = $('#product-card');

  if (productCard.length) {

    zoomUpdater();

    let productPage = new ProductCommons(productCard);
    productPage.init(true, true, true, true, true, false, false);

    prestashop.on('updatedProduct', function (event) {
      if (event && event.product_minimal_quantity) {
        const minimalProductQuantity = parseInt(event.product_minimal_quantity, 10);
        const quantityInputSelector = '#quantity_wanted';
        let quantityInput = $(quantityInputSelector);
        quantityInput.trigger('touchspin.updatesettings', {min: minimalProductQuantity});
      }
      productPage.init(true, true, true, true, true, false, false);
      zoomUpdater();
    });
  }
});

function zoomUpdater () {
  $('#sidebarImages li').on('mouseenter', function (e) {
    $('#sidebarImages').find('.product-cover').removeClass('product-cover');
    $('#sidebarImages').find('img').removeClass('selected');
    $(e.currentTarget).addClass('product-cover').find('img').addClass('selected');
    let imgLarge = $(e.currentTarget).find('img');
    imgLarge.attr('src', imgLarge.attr('data-image-large-src'));
    window.dispatchEvent(new Event('resize'));
  });
}
