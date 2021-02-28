/*
 * 2002-2018 Zemez
 *
 * JX Look Book
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the General Public License (GPL 2.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/GPL-2.0

 * @author     Zemez
 * @copyright  2002-2018 Zemez
 * @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */
$(document).ready(function() {
  $('.js-product-miniature').each(function() {
    var $percent = $(this).find('.discount-percentage');
    var $onsale = $(this).find('.on-sale');
    var $new = $(this).find('.new');
    if ($percent.length) {
      if ($percent.height() <= 0) {
        var h = 20;
      } else {
        h = $percent.height();
      }
      $new.css('top', h * 2 + 10);
      $percent.css('top', -$(this).find('.thumbnail-container').height() + $(this).find('.product-description').height() + 10);
    }
    if ($onsale.length) {
      $percent.css('top', parseFloat($percent.css('top')) + $onsale.height() + 10);
      $new.css('top', ($percent.height() * 2 + $onsale.height()) + 10 * 2);
    }
  });
});