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
{block name='product_miniature_item'}
  <article class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
    <div class="product-miniature-container">
      <div class="product-miniature-thumbnail">
        <div class="product-thumbnail">
          {block name='product_thumbnail'}
            <a href="{$product.url}" class="product-thumbnail-link">
              {capture name='displayProductListGallery'}{hook h='displayProductListGallery' product=$product}{/capture}
              {if $smarty.capture.displayProductListGallery}
                {hook h='displayProductListGallery' product=$product}
              {else}
                <img src="{$product.cover.bySize.home_default.url}" alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}" data-full-size-image-url="{$product.cover.large.url}">
              {/if}
            </a>
          {/block}
        </div>
        {block name='product_flags'}
          <ul class="product-flags">
            {foreach from=$product.flags item=flag}
              <li class="product-flag {$flag.type}">{$flag.label}</li>
            {/foreach}
          </ul>
        {/block}
        <div class="product-buttons">
          {block name='quick_view'}
            <a class="quick-view" href="#" title="{l s='Quick view' d='Shop.Theme.Actions'}" data-link-action="quickview" data-img-cover="{$product.cover.large.url}" data-loading-text="{l s='Loading product info...' d='Shop.Theme.Actions'}">
              <i class="linearicons-zoom-in" aria-hidden="true"></i>
            </a>
          {/block}
          {hook h='displayProductListFunctionalButtons' product=$product}
          {if $product.add_to_cart_url && !$configuration.is_catalog && ($product.minimal_quantity < $product.quantity)}
            <a class="add-to-cart" href="{$product.add_to_cart_url}" title="{l s='Add to cart' d='Shop.Theme.Actions'}" rel="nofollow" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" data-link-action="add-to-cart">
              <i class="linearicons-bag2" aria-hidden="true"></i>
            </a>
          {else}
            {if $product.customizable == 0}
              <a itemprop="url" class="add-to-cart" href="{$product.url}" title="{l s='View product' d='Shop.Theme.Actions'}">
                <i class="linearicons-eye" aria-hidden="true"></i>
              </a>
            {else}
              <a itemprop="url" class="add-to-cart" href="{$product.url}" title="{l s='Customize' d='Shop.Theme.Actions'}">
                <i class="linearicons-cog" aria-hidden="true"></i>
              </a>
            {/if}
          {/if}
        </div>
      </div>

      <div class="product-miniature-information">
        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$product}
        {/block}
        {block name='product_name'}
          <h1 class="product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h1>
        {/block}

        {block name='product_description_short'}
          <div class="product-description-short">{$product.description_short|strip_tags|truncate:130:'...' nofilter}</div>
        {/block}

        {block name='product_variants'}
          {if $product.main_variants}
            {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
          {/if}
        {/block}

        {block name='product_price_and_shipping'}
          {if $product.show_price && !$configuration.is_catalog}
            <div class="product-prices-md{if $product.has_discount} with-discount{/if}">
              {if $product.has_discount}
                {hook h='displayProductPriceBlock' product=$product type="old_price"}
                <span class="sr-only">{l s='Regular price' d='Shop.Theme.Catalog'}</span>
                <span class="regular-price">{$product.regular_price}</span>
                {if $product.discount_type === 'percentage'}
                  <span class="discount-percentage discount-product">{$product.discount_percentage}</span>
                {elseif $product.discount_type === 'amount'}
                  <span class="discount-amount discount-product">{$product.discount_amount_to_display}</span>
                {/if}
              {/if}
              {hook h='displayProductPriceBlock' product=$product type="before_price"}
              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span itemprop="price" class="price">{$product.price}</span>
              {hook h='displayProductPriceBlock' product=$product type='unit_price'}
              {hook h='displayProductPriceBlock' product=$product type='weight'}
            </div>
          {/if}
        {/block}

        <div class="product-buttons">
          {block name='quick_view'}
            <a class="quick-view" href="#" title="{l s='Quick view' d='Shop.Theme.Actions'}" data-link-action="quickview" data-img-cover="{$product.cover.large.url}" data-loading-text="{l s='Loading product info...' d='Shop.Theme.Actions'}">
              <i class="linearicons-zoom-in" aria-hidden="true"></i>
            </a>
          {/block}
          {hook h='displayProductListFunctionalButtons' product=$product}
          {if $product.add_to_cart_url && !$configuration.is_catalog && ($product.minimal_quantity < $product.quantity)}
            <a class="add-to-cart" href="{$product.add_to_cart_url}" title="{l s='Add to cart' d='Shop.Theme.Actions'}" rel="nofollow" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" data-link-action="add-to-cart">
              <i class="linearicons-bag2" aria-hidden="true"></i>
            </a>
          {else}
            {if $product.customizable == 0}
              <a itemprop="url" class="add-to-cart" href="{$product.url}" title="{l s='View product' d='Shop.Theme.Actions'}">
                <i class="linearicons-eye" aria-hidden="true"></i>
              </a>
            {else}
              <a itemprop="url" class="add-to-cart" href="{$product.url}" title="{l s='Customize' d='Shop.Theme.Actions'}">
                <i class="linearicons-cog" aria-hidden="true"></i>
              </a>
            {/if}
          {/if}
        </div>
      </div>
    </div>
  </article>
{/block}
