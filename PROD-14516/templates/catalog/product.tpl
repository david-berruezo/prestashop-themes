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
{extends file=$layout}

{block name='head_seo' prepend}
  <link rel="canonical" href="{$product.canonical_url}">
{/block}

{block name='head' append}
  <meta property="og:type" content="product">
  <meta property="og:url" content="{$urls.current_url}">
  <meta property="og:title" content="{$page.meta.title}">
  <meta property="og:site_name" content="{$shop.name}">
  <meta property="og:description" content="{$page.meta.description}">
  <meta property="og:image" content="{$product.cover.large.url}">
  <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
  <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
  <meta property="product:price:amount" content="{$product.price_amount}">
  <meta property="product:price:currency" content="{$currency.iso_code}">
  {if isset($product.weight) && ($product.weight != 0)}
    <meta property="product:weight:value" content="{$product.weight}">
    <meta property="product:weight:units" content="{$product.weight_unit}">
  {/if}
{/block}

{block name='breadcrumb-block'}
  <div class="product-header row align-items-center">
    <div class="col-12 col-md-9">
      {block name='breadcrumb'}
        {include file='_partials/breadcrumb.tpl'}
      {/block}
      {block name='page_header'}
        {assign var=productWords value=" "|explode:$product.name}
        {assign var=wordsCount value=($productWords|@count/2)|floor}
        {block name='page_title'}
          <h1 class="product-name" itemprop="name"><b>{foreach from=$productWords item=word name=words} {$word} {if $smarty.foreach.words.iteration == $wordsCount}</b>{/if}{/foreach}</h1>
        {/block}
      {/block}
    </div>
    <div class="col-12 col-md-3 order-md-first">
      {block name='product_details'}
        {include file='catalog/_partials/product-details.tpl'}
      {/block}
    </div>
  </div>
{/block}

{block name='content'}
  <section id="main" itemscope itemtype="https://schema.org/Product">
    <meta itemprop="url" content="{$product.url}">
    <div id="product-card">
      <div class="row">
        <div class="col-12 col-md-6 col-lg-7">
          {block name='page_content_container'}
            <section class="page-content" id="content">
              {block name='page_content'}
                {block name='product_cover_thumbnails'}
                  {include file='catalog/_partials/product-cover-thumbnails.tpl'}
                {/block}
              {/block}
            </section>
          {/block}
        </div>
        <div class="col-12 col-md-6 col-lg-5 col-xxl-4 offset-xxl-1 product-info">
          {block name='page_header_container'}
            {block name='product_description_short'}
              <div id="product-description-short-{$product.id}" class="product-description d-none d-lg-block" itemprop="description">{$product.description_short nofilter}</div>
            {/block}
          {/block}

          <div class="product-information">
            {if $product.is_customizable && count($product.customizations.fields)}
              {block name='product_customization'}
                {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
              {/block}
            {/if}

            <div class="product-actions">
              {block name='product_buy'}
                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                  <input type="hidden" name="token" value="{$static_token}">
                  <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                  <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id">

                  {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                  {/block}

                  {block name='product_prices'}
                    {include file='catalog/_partials/product-prices.tpl'}
                  {/block}

                  {block name='product_pack'}
                    {if $packItems}
                      <section class="product-pack mb-3">
                        <h3 class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</h3>
                        <div class="product-pack-row row">
                          {foreach from=$packItems item="product_pack"}
                            {block name='product_miniature'}
                              {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
                            {/block}
                          {/foreach}
                        </div>
                      </section>
                    {/if}
                  {/block}

                  {block name='product_discounts'}
                    {include file='catalog/_partials/product-discounts.tpl'}
                  {/block}

                  {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart.tpl'}
                  {/block}

                  {* Input to refresh product HTML removed, block kept for compatibility with themes *}
                  {block name='product_refresh'}{/block}

                </form>
              {/block}
            </div>
          </div>
        </div>
      </div>
    </div>
    {block name='product_tabs'}
      <div id="tab-content">
        {if $product.description}
          <div id="description" class="row">
            {block name='product_description'}
              <div class="tab-title col-12 col-lg-3 col-xl-4">
                <a class="h4" data-toggle="collapse" href="#description-collapse" role="button" aria-expanded="true">{l s='Description' d='Shop.Theme.Catalog'}</a>
              </div>
              <div id="description-collapse" class="product-description collapse show col-12 col-lg-8 col-xl-7 offset-lg-1">{$product.description nofilter}</div>
            {/block}
          </div>
        {/if}

        {block name='product_features'}
          {include file='catalog/_partials/product-features.tpl'}
        {/block}

        {block name='product_attachments'}
          {if $product.attachments}
            <div id="attachments" class="row">
              <div class="tab-title col-12 col-lg-3 col-xl-4">
                <a class="h4 collapsed" data-toggle="collapse" href="#attachments-collapse" role="button" aria-expanded="false">{l s='Attachments' d='Shop.Theme.Catalog'}</a>
              </div>
              <section id="attachments-collapse" class="product-attachments collapse col-12 col-lg-8 col-xl-7 offset-lg-1">
                <h3 class="h4">{l s='Download' d='Shop.Theme.Actions'}</h3>
                {foreach from=$product.attachments item=attachment}
                  <div class="attachment mb-2">
                    <h6 class="h6"><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></h6>
                    <p>{$attachment.description}</p>
                    <a class="btn btn-sm btn-default" href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                      {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                    </a>
                  </div>
                {/foreach}
              </section>
            </div>
          {/if}
        {/block}
        {foreach from=$product.extraContent item=extra key=extraKey}
          <div id="extra-{$extraKey}" class="row" {foreach $extra.attr as $key => $val} {$key}="{$val}"{/foreach}>
            <div class="tab-title col-12 col-lg-3 col-xl-4">
              <a class="h4 collapsed" data-toggle="collapse" href="#extra-{$extraKey}-collapse" role="button" aria-expanded="false">{$extra.title}</a>
            </div>
            <div id="extra-{$extraKey}-collapse" class="collapse col-12 col-lg-8 col-xl-7 offset-lg-1">
              {$extra.content nofilter}
            </div>
          </div>
        {/foreach}
      </div>
    {/block}

    {block name='product_accessories'}
      {if $accessories}
        <section class="product-accessories grid u-carousel uc-el-product-miniature uc-nav mt-4 mt-lg-5">
          <h1 class="h5 text-center">{l s='You might also like' d='Shop.Theme.Catalog'}</h1>
          <div class="products">
            {foreach from=$accessories item="product_accessory"}
              {block name='product_miniature'}
                {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory}
              {/block}
            {/foreach}
          </div>
        </section>
      {/if}
    {/block}

    {block name='product_footer'}
      {assign var='displayMegaProductFooter' value={hook h='jxMegaLayoutProductFooter' product=$product category=$category}}
      {if $displayMegaProductFooter}
        {$displayMegaProductFooter nofilter}
      {else}
        {hook h='displayFooterProduct' product=$product category=$category}
      {/if}
    {/block}

    {block name='product_images_modal'}
      {include file='catalog/_partials/product-images-modal.tpl' productZoom=true}
    {/block}

    {block name='page_footer_container'}
      <footer class="page-footer">
        {block name='page_footer'}
          <!-- Footer content -->
        {/block}
      </footer>
    {/block}
  </section>
{/block}
