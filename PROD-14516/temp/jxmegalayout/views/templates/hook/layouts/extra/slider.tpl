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

<div id="jxml-slider-{$item.id_unique}" class="jxml-slider{if $content.specific_class} {$content.specific_class}{/if}{if $item.specific_class} {$item.specific_class}{/if}" data-options='{
     {if $content.controls}"navigation": { "nextEl": ".swiper-button-next", "prevEl": ".swiper-button-prev" },{/if}
     {if $content.auto_scroll}"autoplay": { "delay": {$content.pause} },{/if}
     {if $content.loop}"loop": true,{/if}
     "slidesPerView": {$content.visible_items},
     "slidesPerGroup": {$content.items_scroll},
     "spaceBetween": {$content.margin},
     "speed": {$content.speed}{if $content.visible_items > 2},
     "breakpoints": { "577": { "slidesPerView": 2, "slidesPerGroup": 2 }}{/if}{if $content.visible_items == 2},
     "breakpoints": { "767": { "slidesPerView": 1, "slidesPerGroup": 1 }}{/if}
}'>
  {if $content.slides}
    <div class="jxml-swiper-container swiper-container {if $content.pager || $content.controls}use-nav{/if}">
      <div class="swiper-wrapper">
        {foreach from=$content.slides name='slide' item='slide'}
          {if $slide.info}
            <div class="jxml-slides swiper-slide" data-slide-title="{$slide.info.name}" data-number="{if $smarty.foreach.slide.iteration < 10}0{/if}{$smarty.foreach.slide.iteration}">
              {if $slide.entity.type == "html"}
                {include file="./html.tpl" content=$slide.info nested=true}
              {elseif $slide.entity.type == "banner"}
                {include file="./banner.tpl" content=$slide.info nested=true}
              {elseif $slide.entity.type == "video"}
                {include file="./video.tpl" content=$slide.info nested=true}
              {elseif $slide.entity.type == "product"}
                {include file="./product.tpl" content=$slide.info}
              {elseif $slide.entity.type == "post"}
                {include file="./post.tpl" content=$slide.info}
              {/if}
            </div>
          {/if}
        {/foreach}
      </div>
      {if $content.pager}
        <div class="swiper-pagination" data-divider="{l s='of' mod='jxmegalayout'}"></div>
      {/if}
      {if $content.controls}
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
      {/if}
    </div>
  {/if}
  {if $content.content}
    <div class="jxml-slider-description">{$content.content nofilter}</div>
  {/if}
</div>