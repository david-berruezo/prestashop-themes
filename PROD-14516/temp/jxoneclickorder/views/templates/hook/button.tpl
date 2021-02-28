{**
* 2017-2018 Zemez
*
* JX One Click Order
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
*  @copyright 2017-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
{if isset($page) && $page == 'cart'}
  <div class="w-100 mt-2">
    <a href="#" class="link link-primary" id="add_preorder">
      {l s='Buy in one click' mod='jxoneclickorder'}
    </a>
  </div>
{else}
  {if isset($cart.minimalPurchase) && $cart.minimalPurchase && $cart.minimalPurchase > $product.price}
    <div class="w-100">
      <h6>
        {l s='Buy in one click' mod='jxoneclickorder'}
      </h6>
      <div class="alert alert-warning">
        <small>{l s='You cannot use this option to buy the product, because it\'s price is lower than the store rules require. The minimum cost should be not less than %1$d(%2$s). Please, use the default shopping cart option.' sprintf=[$cart.minimalPurchase, $currency.iso_code] mod='jxoneclickorder'}</small>
      </div>
    </div>
  {else}
    <div class="w-100">
      <a href="#" class="link link-primary" id="add_preorder">
        {l s='Buy in one click' mod='jxoneclickorder'}
      </a>
    </div>
  {/if}
{/if}