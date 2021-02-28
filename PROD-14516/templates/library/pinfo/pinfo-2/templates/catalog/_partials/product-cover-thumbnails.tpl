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
<div class="images-container">
  {if $product.cover}
    {block name='product_images'}
      <div class="mobile-product-slider">
        <div class="swiper-container">
          <div class="swiper-wrapper">
            {foreach from=$product.images item=image name=image}
              <div id="_mobile_product_image_{$smarty.foreach.image.iteration - 1}" class="swiper-slide"></div>
            {/foreach}
          </div>
        </div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
      </div>
      <ul id="sidebarImages" class="product-images d-none d-md-block">
        {foreach from=$product.images item=image name=image}
          <li id="_desktop_product_image_{$smarty.foreach.image.iteration - 1}">
            <img
              class="img-fluid js-thumb{if $image.id_image == $product.cover.id_image} selected{/if}"
              data-image-medium-src="{$image.bySize.medium_default.url}"
              data-image-large-src="{$image.bySize.large_default.url}"
              data-index="{$smarty.foreach.image.iteration - 1}"
              src="{$image.bySize.large_default.url}"
              alt="{$image.legend}"
              title="{$image.legend}"
              itemprop="image"
            >
            <div class="layer" data-toggle="modal" data-target="#product-modal"><i class="icon-zoom_out_map"></i></div>
          </li>
        {/foreach}
      </ul>
    {/block}
  {else}
    <img src="{$urls.no_picture_image.bySize.medium_default.url}" style="width:100%;">
  {/if}
  {block name='product_flags'}
    <ul class="product-flags">
      {foreach from=$product.flags item=flag}
        <li class="product-flag {$flag.type}">{$flag.label}</li>
      {/foreach}
    </ul>
  {/block}
</div>
{hook h='displayAfterProductThumbs'}