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
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  <div class="block-category">
    <div class="row">
      <div class="col-12 col-sm-4">
        {assign var=categoryWords value=" "|explode:$category.name}
        <h2 class="h1">{foreach from=$categoryWords item=word name=words}{if $smarty.foreach.words.first}<b>{$word}</b>{else}{$word}{/if} {/foreach}</h2>
      </div>
      <div class="col-12 col-sm-8 d-flex align-items-center">
        {if $category.description}
          <div class="category-description">
            {$category.description nofilter}
          </div>
        {/if}
      </div>
    </div>
  </div>
{/block}
