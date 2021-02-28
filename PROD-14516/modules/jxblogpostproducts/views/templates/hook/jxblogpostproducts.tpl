{*
* 2017 Zemez
*
* JX Blog Post Products
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
*  @author    Zemez (Alexander Grosul)
*  @copyright 2017 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if $products}
  <section class="related-products grid-large">
    <h2 class="h3">{l s='Related products' mod='jxblogpostproducts'}</h2>
    <div class="products">
    {foreach from=$products item='product'}
      {include file="catalog/_partials/miniatures/product.tpl" product=$product}
    {/foreach}
  </section>
{/if}

