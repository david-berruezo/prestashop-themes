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

<div id="quickview-modal-{$product.id}-{$product.id_product_attribute}" class="quickview modal fade modal-close-inside" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <button type="button" class="close icon-close" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
      <button type="button" class="close linearicons-cross" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
      <div class="modal-body">
        <div id="quickview-product-card" class="row">
          <div class="col-12 col-md-7 pr-md-3">
            {include file='catalog/_partials/product-images-modal.tpl' quikview=true}
          </div>
          <div class="col-12 col-md-5 product-info">
            <div id="quickview-product-details">
              {block name='product_details'}
                {include file='catalog/_partials/product-details.tpl'}
              {/block}
            </div>
            <h1 class="h6 product-name">{$product.name}</h1>
            {block name='product_prices'}
              {include file='catalog/_partials/product-prices.tpl'}
            {/block}
            {block name='product_buy'}
              <div class="product-actions">
                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                  <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id">
                  {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                  {/block}
                  {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart.tpl'}
                  {/block}
                  {* Input to refresh product HTML removed, block kept for compatibility with themes *}
                  {block name='product_refresh'}{/block}
                </form>
              </div>
            {/block}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

{block name='product_images_modal'}
  {include file='catalog/_partials/product-images-modal.tpl' productZoom=true}
{/block}
