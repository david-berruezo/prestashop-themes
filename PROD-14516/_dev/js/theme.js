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

import 'bootstrap';
import 'flexibility';
import 'bootstrap-touchspin';
import 'jquery-range';
import 'theia-sticky-sidebar/dist/theia-sticky-sidebar.min.js';

import './partials/checkout';
import './partials/customer';
import './partials/listing';
import './partials/cart';

import './components/responsive';
import './components/block-cart';
import DropDown from './components/drop-down';
import Form from './components/form';
import universalCarousel from './components/carousels';

import EventEmitter from 'events';

import './lib/jquery.scrollbox.min';
import './lib/jquery.stickup.min';
import './lib/slidebars';
import './lib/jquery.uitotop.min';

// "inherit" EventEmitter
for (var i in EventEmitter.prototype) {
  prestashop[i] = EventEmitter.prototype[i];
}

$(document).ready(() => {
  let stickUp = $(".stick-up");
  if (stickUp.length && $('body').width() > 1199) {
    stickUp.wrap('<div class="stickUpTop"><div class="stickUpHolder">');
    $('.stickUpTop').tmStickUp();
  }
  let dropDownEl = $('.js-dropdown');
  const form = new Form();
  let dropDown = new DropDown(dropDownEl);
  let customCarousel = new universalCarousel($('.u-carousel'));
  dropDown.init();
  customCarousel.init();
  form.init();
  if (!prestashop.responsive.mobile) {
    $('html').UItoTop({
      easingType: 'easeOutQuart',
      containerClass: 'ui-to-top'
    });
  }

  $('.sidebar').theiaStickySidebar({
    updateSidebarHeight: true,
    minWidth: 768,
    additionalMarginTop: 80,
    additionalMarginBottom: 40
  });

  if ($('html').height() < window.innerHeight) {
    $('html').css('height', '100%');
  }
});