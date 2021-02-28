{**
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
*}

<li class="compare-product-element" data-id-product="{$product.info.id_product}">
  <div class="product-thumbnail">
    <img class="img-fluid" src="{$product.info.cover.bySize.small_default.url}" alt="{$product.info.cover.legend}" />
    <a href="#" class="js-compare-button close-product" data-action="remove-product" data-id-product="{$product.info.id_product}"><span class="linearicons-cross" aria-hidden="true"></span></a>
  </div>
</li>

