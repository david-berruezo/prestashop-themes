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
<article class="product-miniature js-product-miniature" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" itemscope itemtype="http://schema.org/Product">
  <div class="thumbnail-container">
      <a href="{$product.url}" class="thumbnail product-thumbnail">
        <img
                src = "{$product.cover.bySize.home_default.url}"
                alt = "{$product.cover.legend}"
                data-full-size-image-url = "{$product.cover.large.url}"
        >
      </a>

    <div class="product-description">
        <h1 class="h3 product-title" itemprop="name"><a href="{$product.link}">{$product.name|truncate:30:'...'}</a></h1>

        {if $product.show_price}
          <div class="product-price-and-shipping">
            {if $product.has_discount}
              {hook h='displayProductPriceBlock' product=$product type="old_price"}

              <span class="regular-price">{$product.regular_price}</span>
              {if $product.discount_type === 'percentage'}
                <span class="discount-percentage">{$product.discount_percentage}</span>
              {/if}
            {/if}

            {hook h='displayProductPriceBlock' product=$product type="before_price"}

            <span itemprop="price" class="price">{$product.price}</span>

            {hook h='displayProductPriceBlock' product=$product type='unit_price'}

            {hook h='displayProductPriceBlock' product=$product type='weight'}
          </div>
        {/if}
    </div>
      <ul class="product-flags">
        {foreach from=$product.flags item=flag}
          <li class="{$flag.type}">{$flag.label}</li>
        {/foreach}
      </ul>

    <div class="highlighted-informations{if !$product.main_variants} no-variants{/if} hidden-sm-down">
      <a
              href="#"
              class="quick-view"
              data-link-action="quickview"
      >
        <i class="material-icons search">&#xE8B6;</i> {l s='Quick view' d='Shop.Theme.Actions'}
      </a>

        {if $product.main_variants}
          {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
        {/if}
    </div>

  </div>
</article>
