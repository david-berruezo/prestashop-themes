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

<div id="product-details" data-product="{$product.embedded_attributes|json_encode}" class="product-top">
  <div class="details-table">
    {block name='product_reference'}
      {if isset($product.reference_to_display)}
        <div class="product-reference">
          <label>{l s='Reference' d='Shop.Theme.Catalog'} </label>
          <span itemprop="sku">{$product.reference_to_display}</span>
        </div>
      {/if}
    {/block}

    {block name='product_quantities'}
      {if $product.show_quantities}
        <div class="product-quantities">
          <label>{l s='In stock' d='Shop.Theme.Catalog'}</label>
          <span>{$product.quantity} {$product.quantity_label}</span>
        </div>
      {/if}
    {/block}

    {block name='product_condition'}
      {if $product.condition}
        <div class="product-condition">
          <label>{l s='Condition' d='Shop.Theme.Catalog'} </label>
          <link itemprop="itemCondition" href="{$product.condition.schema_url}"/>
          <span>{$product.condition.label}</span>
        </div>
      {/if}
    {/block}

    {block name='product_availability_date'}
      {if $product.availability_date}
        <div class="product-availability-date">
          <label>{l s='Availability date:' d='Shop.Theme.Catalog'} </label>
          <span>{$product.availability_date}</span>
        </div>
      {/if}
    {/block}
  </div>

  {block name='product_out_of_stock'}
    <div class="product-out-of-stock">
      {hook h='actionProductOutOfStock' product=$product}
    </div>
  {/block}
</div>