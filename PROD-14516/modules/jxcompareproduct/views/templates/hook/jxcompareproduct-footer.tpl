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

<section id="compare-footer" data-refresh-url="{$jxcompareproduct_url}" data-compare-max="{$jxcompareproduct_max}" data-empty-text="{l s='No products to compare' mod='jxcompareproduct'}"
         data-max-alert-message="{l s='Only' mod='jxcompareproduct'} {$jxcompareproduct_max} {l s='products can be compared' mod='jxcompareproduct'}">
  <span class="compare-footer-grover clone-slidebar-toggle slidebar-toggle-animated" data-id-slidebar="compare-slidebar">
    <i class="linearicons-balance" aria-hidden="true"></i>
    <span class="compare-counter"></span>
  </span>
  <div data-off-canvas="compare-slidebar bottom push">
    <ul id="compare-list-footer"></ul>
    <div class="buttons">
      <a class="compare-products" title="{l s='Compare' mod='jxcompareproduct'}" href="#">{l s='Compare now' mod='jxcompareproduct'}</a>
      <a class="compare-clear" title="{l s='Clear compare' mod='jxcompareproduct'}" href="#">{l s='Remove all' mod='jxcompareproduct'}</a>
    </div>
  </div>
</section>