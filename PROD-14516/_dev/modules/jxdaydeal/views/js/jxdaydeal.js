import universalCarousel from "../../../../js/components/carousels";
import DropDown from "../../../../js/components/drop-down";
import Form from "../../../../js/components/form";

/**
* 2002-2018 Zemez
*
* Zemez Deal of Day
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
*  @author    Zemez (Sergiy Sakun)
*  @copyright 2002-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*/

$(document).ready(() => {
  new Swiper('.daydeal-products', {
    autoplay: {
      delay: 5000
    },
    effect: 'fade',
    pagination: {
      el: '.daydeal-pagination',
      clickable: true,
      type: 'bullets'
    }
  });
});