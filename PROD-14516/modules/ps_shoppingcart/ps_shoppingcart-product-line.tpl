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

<div class="media">
  <a class="product-thumbnail" href="{$product.url}" title="{$product.name}">
    <img src="{$product.cover.bySize.small_default.url}" class="img-fluid" alt="{$product.name}"/>
  </a>
  <div class="media-body">
    <a class="remove-from-cart close"
       rel="nofollow"
       href="{$product.remove_from_cart_url}"
       data-link-action="remove-from-cart"
       aria-label="Close"
    >
      <span class="linearicons-cross" aria-hidden="true"></span>
    </a>
    <h3 class="h6 product-title">{$product.name}</h3>
    {if $product.attributes}
      <div class="product-attributes">
        {foreach from=$product.attributes name='myloop' item='attribute'}
          <small>{if $smarty.foreach.myloop.iteration > 1}-{/if}{$attribute}</small>{/foreach}
      </div>
    {/if}
    <div class="product-prices-md">
      <span class="price">{$product.price}</span>
      {hook h='displayProductPriceBlock' product=$product type="unit_price"}
    </div>
    <div class="product-quantity">{l s='Quantity' d='Shop.Theme.Actions'}: {$product.quantity}</div>
    {if $product.customizations|count}
      <div class="customizations-toggle">
        {foreach from=$product.customizations item="customization"}
          <a class="btn-link btn-link-primary" data-toggle="collapse" href="#customization-{$customization.id_customization}" aria-expanded="false" aria-controls="customization-{$customization.id_customization}">
            {l s='Product customization' d='Shop.Theme.Catalog'}
          </a>
        {/foreach}
      </div>
    {/if}
  </div>
</div>
{if $product.customizations|count}
  {foreach from=$product.customizations item="customization"}
    <div id="customization-{$customization.id_customization}" class="customization collapse mt-3">
      <ul class="list-group">
        {foreach from=$customization.fields item="field"}
          <li class="list-group-item">
            <label>{$field.label}</label>
            <div>
              {if $field.type == 'text'}
                <small>{$field.text}</small>
              {elseif $field.type == 'image'}
                <img src="{$field.image.small.url}" class="img-fluid">
              {/if}
            </div>
          </li>
        {/foreach}
      </ul>
    </div>
  {/foreach}
{/if}