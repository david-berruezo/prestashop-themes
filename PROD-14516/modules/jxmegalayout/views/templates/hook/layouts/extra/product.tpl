{**
* 2002-2018 Zemez
*
* JX Mega Layout
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
*  @author    Zemez (Alexander Grosul & Alexander Pervakov)
*  @copyright 2002-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
{block name='product_miniature_item'}
  <article class="product-miniature js-product-miniature" data-id-product="{$content.id_product}" data-id-product-attribute="{$content.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
    <div class="product-miniature-container">
      <div class="product-miniature-thumbnail">
        <div class="product-thumbnail">
          {block name='product_thumbnail'}
            <a href="{$content.url}" class="product-thumbnail-link">
              {capture name='displayProductListGallery'}{hook h='displayProductListGallery' product=$content}{/capture}
              {if $smarty.capture.displayProductListGallery}
                {hook h='displayProductListGallery' product=$content}
              {else}
                <img src="{$content.cover.bySize.home_default.url}" alt="{if !empty($content.cover.legend)}{$content.cover.legend}{else}{$content.name|truncate:30:'...'}{/if}" data-full-size-image-url="{$content.cover.large.url}">
              {/if}
            </a>
          {/block}
        </div>
        {block name='product_flags'}
          <ul class="product-flags">
            {foreach from=$content.flags item=flag}
              <li class="product-flag {$flag.type}">{$flag.label}</li>
            {/foreach}
          </ul>
        {/block}
        <div class="product-buttons">
          {block name='quick_view'}
            <a class="quick-view" href="#" title="{l s='Quick view' d='Shop.Theme.Actions'}" data-link-action="quickview" data-img-cover="{$content.cover.large.url}" data-loading-text="{l s='Loading product info...' d='Shop.Theme.Actions'}">
              <i class="linearicons-zoom-in" aria-hidden="true"></i>
            </a>
          {/block}
          {hook h='displayProductListFunctionalButtons' product=$content}
          {if $content.add_to_cart_url && !$configuration.is_catalog && ({$content.minimal_quantity} < {$content.quantity})}
            <a class="add-to-cart" href="{$content.add_to_cart_url}" title="{l s='Add to cart' d='Shop.Theme.Actions'}" rel="nofollow" data-id-product="{$content.id_product}" data-id-product-attribute="{$content.id_product_attribute}" data-link-action="add-to-cart">
              <i class="linearicons-bag2" aria-hidden="true"></i>
            </a>
          {else}
            {if $content.customizable == 0}
              <a itemprop="url" class="add-to-cart" href="{$content.url}" title="{l s='View product' d='Shop.Theme.Actions'}">
                <i class="linearicons-eye" aria-hidden="true"></i>
              </a>
            {else}
              <a itemprop="url" class="add-to-cart" href="{$content.url}" title="{l s='Customize' d='Shop.Theme.Actions'}">
                <i class="linearicons-cog" aria-hidden="true"></i>
              </a>
            {/if}
          {/if}
        </div>
      </div>

      <div class="product-miniature-information">
        {block name='product_reviews'}
          {hook h='displayProductListReviews' product=$content}
        {/block}
        {block name='product_name'}
          <h1 class="product-title" itemprop="name"><a href="{$content.url}">{$content.name|truncate:30:'...'}</a></h1>
        {/block}
        {block name='product_price_and_shipping'}
          {if $content.show_price && !$configuration.is_catalog}
            <div class="product-prices-md{if $content.has_discount} with-discount{/if}">
              {if $content.has_discount}
                {hook h='displayProductPriceBlock' product=$content type="old_price"}
                <span class="sr-only">{l s='Regular price' d='Shop.Theme.Catalog'}</span>
                <span class="regular-price">{$content.regular_price}</span>
                {if $content.discount_type === 'percentage'}
                  <span class="discount-percentage discount-product">{$content.discount_percentage}</span>
                {elseif $content.discount_type === 'amount'}
                  <span class="discount-amount discount-product">{$content.discount_amount_to_display}</span>
                {/if}
              {/if}
              {hook h='displayProductPriceBlock' product=$content type="before_price"}
              <span class="sr-only">{l s='Price' d='Shop.Theme.Catalog'}</span>
              <span itemprop="price" class="price">{$content.price}</span>
              {hook h='displayProductPriceBlock' product=$content type='unit_price'}
              {hook h='displayProductPriceBlock' product=$content type='weight'}
            </div>
          {/if}
        {/block}
      </div>
    </div>
    <script id="quickview-template-{$content.id}-{$content.id_product_attribute}" type="text/template">
      <div id="quickview-modal-{$content.id}-{$content.id_product_attribute}" class="quickview modal fade modal-close-inside" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <button type="button" class="close linearicons-cross" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
            <div class="modal-body">
              <div class="row">
                <div class="col-12 col-md-7 pr-md-3">
                  <div class="img-wrap">
                    {block name='product_cover_thumbnails'}
                      {include file='catalog/_partials/product-cover-thumbnails.tpl' product=$content}
                    {/block}
                  </div>
                </div>
                <div class="col-12 col-md-5 product-info">
                  <div id="quickview-product-details"></div>
                  <h1 class="h6 product-name">{$content.name}</h1>
                  <div id="quickview-product-prices"></div>
                  {block name='product_buy'}
                    <div id="quickview-product-addToCart" class="product-actions"></div>
                  {/block}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </script>
  </article>
{/block}