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
 * DISCLAIMERalign-content-center
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
<div class="product-add-to-cart">
  <div class="product-quantity d-flex flex-wrap align-items-center">
    {if !$configuration.is_catalog}
      {block name='product_quantity'}
        <div class="qty mb-2 mr-2">
          <input type="text" name="qty" id="quantity_wanted" value="{$product.quantity_wanted}" class="form-control-lg" min="{$product.minimal_quantity}" aria-label="{l s='Quantity' d='Shop.Theme.Actions'}">
        </div>
        <div class="add mb-2 mr-2 mr-lg-3">
          <button class="btn btn-primary btn-lg add-to-cart" data-button-action="add-to-cart" type="submit"{if !$product.add_to_cart_url} disabled{/if}>
            {l s='Add to cart' d='Shop.Theme.Actions'} <i></i>
          </button>
        </div>
      {/block}
    {/if}
    {block name='product_additional_info'}
      {include file='catalog/_partials/product-additional-info.tpl'}
    {/block}
  </div>

  {if !$configuration.is_catalog}
    {block name='product_availability'}
      <span id="product-availability">
        {if $product.show_availability && $product.availability_message}
          <span class="{if $product.availability == 'available'}product-available{elseif $product.availability == 'last_remaining_items'}product-last-items{else}product-unavailable{/if}">
            {$product.availability_message}
          </span>
        {/if}
      </span>
    {/block}
    
    {block name='product_minimal_quantity'}
      {if $product.minimal_quantity > 1}
        <p class="product-minimal-quantity required">
          {l
          s='The minimum purchase order quantity for the product is %quantity%.'
          d='Shop.Theme.Checkout'
          sprintf=['%quantity%' => $product.minimal_quantity]
          }
        </p>
      {/if}
    {/block}
  {/if}
</div>