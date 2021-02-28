{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

  <div class="product-miniature-home product-miniature-{$key|escape:'htmlall':'UTF-8'}" data-id-product="{$product.id_product|escape:'htmlall':'UTF-8'}" data-id-product-attribute="{$product.id_product_attribute|escape:'htmlall':'UTF-8'}" >
    <div class="thumbnail-container-home">


        <div class="thumbnail-featured">
            <div class="product-thumbnail-home">
                <a href="{$product.url|escape:'htmlall':'UTF-8'}" class="product-thumbnail-home">
                    <img src = "{$product.cover.bySize.medium_default.url|escape:'htmlall':'UTF-8'}" alt = "{$product.cover.legend|escape:'htmlall':'UTF-8'}" data-full-size-image-url = "{$product.cover.large.url|escape:'htmlall':'UTF-8'}" >
                </a>

                <ul class="product-flags">
                    {foreach from=$product.flags item=flag}
                        {if $flag.type !== 'discount'}
                            <li class="{$flag.type|escape:'htmlall':'UTF-8'}">{$flag.label|escape:'htmlall':'UTF-8'}</li>
                        {/if}
                    {/foreach}

                    {if $product.discount_type === 'percentage' && $product.has_discount}
                        <li class="discount-percentage">{$product.discount_percentage|escape:'htmlall':'UTF-8'}</li>
                    {/if}
                </ul>
            </div>


            <div class="product-description-home">
                {if $product.main_variants}
                    {include file='catalog/_partials/variant-links.tpl' variants=$product.main_variants}
                {/if}

                <h2 class="h3 product-title"><a href="{$product.url|escape:'htmlall':'UTF-8'}">{$product.name|truncate:30:'...'|escape:'htmlall':'UTF-8'}</a></h2>

                {if $product.show_price}
                    <div class="product-price-and-shipping">


                        {hook h='displayProductPriceBlock' product=$product type="before_price"}

                        <span  class="price">{$product.price|escape:'htmlall':'UTF-8'}</span>

                        {hook h='displayProductPriceBlock' product=$product type='unit_price'}

                        {hook h='displayProductPriceBlock' product=$product type='weight'}

                        {if $product.has_discount}
                            {hook h='displayProductPriceBlock' product=$product type="old_price"}
                            <span class="regular-price">{$product.regular_price|escape:'htmlall':'UTF-8'}</span>
                        {/if}
                    </div>
                {/if}
            </div>
        </div>



    </div>
  </div>

