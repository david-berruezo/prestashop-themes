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

<div id="blockcart-modal" class="modal fade modal-close-inside" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm" role="document">
    <div class="modal-content">
      <button type="button" class="close linearicons-cross" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
      <div class="modal-body">
        <i class="linearicons-check" aria-hidden="true"></i>
        <h4>{l s='Product successfully added to your shopping cart' d='Shop.Theme.Checkout'}</h4>
        <div class="product-thumbnail">
          <img class="img-fluid" src="{$product.cover.bySize.home_default.url}" alt="{$product.name}"/>
        </div>
        <h3 class="h6 product-title"><a href="{$product.url}" title="{$product.name}">{$product.name}</a></h3>


        <div class="list-inline-separated">
          {foreach from=$product.attributes item="property_value" key="property"}
            <small>{$property}: {$property_value}</small>
          {/foreach}
        </div>
        <div class="product-quantity">{l s='Quantity' d='Shop.Theme.Checkout'}: {$product.cart_quantity}</div>
        <div class="product-prices-md"><span class="price">{$product.total}</span></div>
      </div>
      <div class="modal-footer">
        <div>
          {if $cart.products_count > 1}
            <h4>{l s='There are %products_count% items in your cart.' sprintf=['%products_count%' => $cart.products_count] d='Shop.Theme.Checkout'}</h4>
          {else}
            <h4>{l s='There is %product_count% item in your cart.' sprintf=['%product_count%' =>$cart.products_count] d='Shop.Theme.Checkout'}</h4>
          {/if}
          {foreach from=$cart.subtotals item="subtotal"}
            {if $subtotal.value}
              <div class="modal-cart-{$subtotal.type} subtotal d-flex justify-content-between">
                <span class="label">{$subtotal.label}</span>
                <span class="value">{$subtotal.value}</span>
              </div>
            {/if}
          {/foreach}
          <div class="modal-cart-total subtotal d-flex justify-content-between">
            <span class="label">{$cart.totals.total.label}</span>
            <span class="value">{$cart.totals.total.value}
              <small>{$cart.labels.tax_short}</small>
            </span>
          </div>
        </div>
        <div class="footer-buttons">
          <button type="button" class="btn btn-custom-white" data-dismiss="modal">{l s='Continue shopping' d='Shop.Theme.Actions'}</button>
          <a class="btn btn-custom-red" href="{$cart_url}" title="{l s='Proceed to checkout' d='Shop.Theme.Actions'}">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
        </div>
      </div>
    </div>
  </div>
</div>