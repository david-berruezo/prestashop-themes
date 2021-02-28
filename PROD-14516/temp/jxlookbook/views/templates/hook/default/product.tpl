{**
* 2002-2018 Zemez
*
* JX Look Book
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
{block name='product_miniature_item'}
  <article class="product-miniature-small mt-0 p-2" itemscope itemtype="http://schema.org/Product">
    <div class="product-miniature-container row no-gutters">
      <div class="product-miniature-thumbnail col-auto">
        <div class="product-thumbnail">
          {block name='product_thumbnail'}
            <a href="{$product.url}" class="product-thumbnail-link">
              <img src="{$product.cover.bySize.small_default.url}" alt="{if !empty($product.cover.legend)}{$product.cover.legend}{else}{$product.name|truncate:30:'...'}{/if}">
            </a>
          {/block}
        </div>
      </div>
      <div class="product-miniature-information col pl-2">
        {block name='product_name'}
          <h1 class="product-title" itemprop="name"><a href="{$product.url}">{$product.name|truncate:30:'...'}</a></h1>
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
      </div>
    </div>
  </article>
{/block}
