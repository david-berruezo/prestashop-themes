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

import $ from 'jquery';

export default class universalCarousel {
  constructor(el) {
    this.el = el;
  }

  init() {
    this.el.each(function () {
      var ucCarouselClasses = $(this).attr('class');
      var ucWrapper = $($($(this).find('.' + ucCarouselClasses.match(/uc-el-(\S+)/i)[1])).parent())[0];
      $(ucWrapper).children().addClass('swiper-slide');
      $(ucWrapper).wrapInner('<div class="swiper-container"><div class="swiper-wrapper">');
      if ($(this).hasClass('uc-pag')) {
        var paginationEl = '.swiper-pagination';
        $(ucWrapper).children('.swiper-container').append('<div class="swiper-pagination"></div>');
      }
      if ($(this).hasClass('uc-nav')) {
        var nextEl = '.swiper-button-next';
        var prevEl = '.swiper-button-prev';
        $(ucWrapper).children('.swiper-container').append('<div class="swiper-button-prev"></div><div class="swiper-button-next"></div>');
      }
      var ucCarousel = new Swiper($(this).find('.swiper-container'), {
        navigation: {
          nextEl: nextEl,
          prevEl: prevEl
        },
        pagination: {
          el: paginationEl,
          clickable: true
        },
        watchOverflow: true,
        slidesPerView: 'auto',
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
    });
  }
}