{**
* 2002-2018 Zemez
*
* JX Category Products
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

{if isset($blocks) && $blocks}
  <section class="jxcategoryproducts">
    <ul class="nav nav-tabs" role="tablist">
      {foreach from=$blocks item='block' name='block'}
        {assign var="block_identificator" value="{$block.id}"}
        <li class="nav-item">
          <a class="nav-link{if $smarty.foreach.block.index == 0} active{/if}" data-toggle="tab" href="#{$hook_class}-block-category-{$block_identificator}" role="tab">{$block.name}</a>
        </li>
      {/foreach}
    </ul>
    <div class="tab-content">
      {foreach from=$blocks item='block' name='block'}
        {assign var="block_identificator" value="{$block.id}"}
        <div class="tab-pane fade{if $smarty.foreach.block.index == 0} show active{/if}{if $block.use_carousel} swiper-container{/if}" id="{$hook_class}-block-category-{$block_identificator}" role="tabpanel">
          {if isset($block.products) && $block.products}
            {if $block.use_carousel}
              <div class="swiper-container">
                <div class="swiper-wrapper">
            {else}
              <div class="products">
            {/if}
                {assign var='products' value=$block.products}
                {foreach from=$products item='product'}
                  {include file="catalog/_partials/miniatures/product.tpl" product=$product}
                {/foreach}
              {if $block.use_carousel}
                </div>
                {if isset($block.carousel_settings.carousel_pager) && $block.carousel_settings.carousel_pager}
                  <div id="{$hook_class}-block-category-{$block_identificator}-swiper-pagination" class="swiper-pagination"></div>
                {/if}
                {if isset($block.carousel_settings.carousel_control) && $block.carousel_settings.carousel_control}
                  <div id="{$hook_class}-block-category-{$block_identificator}-swiper-next" class="swiper-button-next{if isset($block.carousel_settings.carousel_hide_control) && $block.carousel_settings.carousel_hide_control} hideControlOnEnd{/if}"></div>
                  <div id="{$hook_class}-block-category-{$block_identificator}-swiper-prev" class="swiper-button-prev{if isset($block.carousel_settings.carousel_hide_control) && $block.carousel_settings.carousel_hide_control} hideControlOnEnd{/if}"></div>
                {/if}
              {/if}
            </div>
          {else}
            <p class="alert alert-warning">{l s='No products in this category.' mod='jxcategoryproducts'}</p>
          {/if}
        </div>
      {/foreach}
    </div>
  </section>
{/if}