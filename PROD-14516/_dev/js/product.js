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
// 3) Create Product Spin, 4) Create Modal Zoom,
// 5) Create Image Slider, 6) Create Gallery(example: '5 4 3'), 7) Create Vertical Gallery(example: '5-4-3')
import ProductCommons from './components/product-commons';

$(document).ready(function () {
  let productCard = $('#product-card');
  if (productCard.length) {
    let productPage = new ProductCommons(productCard);
    productPage.init(true, true, true, true, false, false, '3-3-3');

    prestashop.on('updatedProduct', function (event) {
      if (event && event.product_minimal_quantity) {
        const minimalProductQuantity = parseInt(event.product_minimal_quantity, 10);
        const quantityInputSelector = '#quantity_wanted';
        let quantityInput = $(quantityInputSelector);
        quantityInput.trigger('touchspin.updatesettings', {min: minimalProductQuantity});
      }
      productPage.init(true, true, true, false, false, false, '3-3-3');
    });
  }
});