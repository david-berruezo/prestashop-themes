{**
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
 *}
<div id="_desktop_cart">
  <div class="blockcart cart-preview" data-refresh-url="{$refresh_url}">
    <a class="clone-slidebar-toggle" data-id-slidebar="blockcart-slidebar" rel="nofollow" href="{$cart_url}" title="{l s='View Cart' d='Shop.Theme.Actions'}">
      <i class="linearicons-bag2" aria-hidden="true"></i>
      {if $cart.products_count > 0}
        <span class="cart-products-count">{$cart.products_count}</span>
      {/if}
    </a>
  </div>
  <div class="cart-summary" data-off-canvas="blockcart-slidebar right overlay">
    <button type="button" class="closeSlidebar linearicons-cross" aria-label="Close"></button>
    <div class="block-cart-body">
      <h4 class="cart-summary-header">{l s='Cart' d='Shop.Theme.Actions'}</h4>
      <ul id="cart-summary-product-list">
        {foreach from=$cart.products item=product}
          <li class="cart-summary-product-item">
            {include 'module:ps_shoppingcart/ps_shoppingcart-product-line.tpl' product=$product}
          </li>
        {/foreach}
      </ul>
      <div class="cart-footer">
        <div class="cart-subtotals">
          {foreach from=$cart.subtotals item="subtotal"}
            {if isset($subtotal) && $subtotal}
              <div class="cart-{$subtotal.type}">
                <span class="label">{$subtotal.label}:</span>
                <span class="value">{$subtotal.value}</span>
                {if $subtotal.type == 'discount'}
                  {if $cart.vouchers.added}
                    <ul class="list-group mb-2 w-100">
                      {foreach from=$cart.vouchers.added item='voucher'}
                        <li class="list-group-item d-flex flex-wrap justify-content-between">
                          <span>{$voucher.name}({$voucher.reduction_formatted})</span><a data-link-action="remove-voucher" href="{$voucher.delete_url}" class="close" aria-label="Close">
                            <span class="linearicons-cross" aria-hidden="true"></span>
                          </a>
                        </li>
                      {/foreach}
                    </ul>
                  {/if}
                {/if}
              </div>
            {/if}
          {/foreach}
        </div>
        <div class="cart-total mt-1 mb-3">
          <span class="label">{$cart.totals.total.label}</span>
          <span class="value">{$cart.totals.total.value}</span>
        </div>
        <a class="btn btn-secondary d-block" href="{$cart_url}" title="{l s='Proceed to checkout' d='Shop.Theme.Actions'}">{l s='Checkout' d='Shop.Theme.Actions'}</a>
      </div>
    </div>
  </div>
</div>