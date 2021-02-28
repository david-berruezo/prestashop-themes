{*
* 2002-2018 Zemez
*
* JX Wishlist
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

{extends file=$layout}

{block name="content"}
  <section id="main">
    <h2>{$current_wishlist.name|escape:'htmlall':'UTF-8'}</h2>
    {if $products}
      <section class="grid">
        <div class="products">
          {foreach from=$products item="product" name=i}
            {include file="catalog/_partials/miniatures/product.tpl" product=$product.info_array}
          {/foreach}
        </div>
      </section>
    {else}
      <p class="alert alert-warning">{l s='No products in this wishlist.' mod='jxwishlist'}</p>
    {/if}
  </section>
{/block}