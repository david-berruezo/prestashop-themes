{*
* 2002-2018 Zemez
*
* Zemez Deal of Day
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
*  @author    Zemez (Sergiy Sakun)
*  @copyright 2002-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<section class="daydeal-products swiper-container">
  {if isset($daydeal_products) && $daydeal_products}
    <div class="swiper-wrapper">
      {foreach from=$daydeal_products item=product name=product}
        <div class="product swiper-slide">
          <div class="container">
            <div class="product-info">
              {if isset($daydeal_products_extra[$product.info.id_product]["label"]) && $daydeal_products_extra[$product.info.id_product]["label"]}
                <h5 class="label-daydeal">{$daydeal_products_extra[$product.info.id_product]["label"]|escape:'htmlall':'UTF-8'}</h5>
              {/if}
              <h1 itemprop="name">{$product.info.name|truncate:27:'...'}</h1>
              {if $product.info.show_price && !$configuration.is_catalog && $product.info.has_discount}
                {hook h='displayProductPriceBlock' product=$product.info type="old_price"}
              {/if}
              <a class="btn btn-custom-white btn-lg" href="{$product.info.url}">{l s='Shop now' mod='jxdaydeal'}</a>
            </div>
            <a class="product-thumb" href="{$product.info.url}">
              <img class="img-fluid" src="{$product.info.cover.bySize.large_default.url}" alt="{$product.info.cover.legend}"/>
            </a>
          </div>
        </div>
      {/foreach}
    </div>
    {if $daydeal_products|@count > 1}
      <div class="daydeal-pagination"></div>
    {/if}
  {else}
    <p class="alert alert-info">{l s='No special products at this time.' mod='jxdaydeal'}</p>
  {/if}
</section>