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

<div class="tab-pane fade in{if !$product.description} active show{/if}"
     id="product-features"
     role="tabpanel"
>
  <div>
    {block name='product_features'}
      {if $product.grouped_features}
        <section class="product-features">
          <dl class="data-sheet">
            {foreach from=$product.grouped_features item=feature}
              <dt class="name">{$feature.name}</dt>
              <dd class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
            {/foreach}
          </dl>
        </section>
      {/if}
    {/block}

    {* if product have specific references, a table will be added to product details section *}
    {block name='product_specific_references'}
      {if isset($product.specific_references)}
        <section class="product-features">
          <h3 class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</h3>
          <dl class="data-sheet">
            {foreach from=$product.specific_references item=reference key=key}
              <dt class="name">{$key}</dt>
              <dd class="value">{$reference}</dd>
            {/foreach}
          </dl>
        </section>
      {/if}
    {/block}
  </div>
</div>
