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
    {if $category.image.large.url}
      <div class="category-cover d-none d-md-block mr-sm-3 mr-lg-4">
        <img class="img-fluid product-thumbnail" src="{$category.image.large.url}" alt="{$category.image.legend}">
      </div>
    {/if}
    <div>
      {assign var=categoryWords value=" "|explode:$category.name}
      <h2 class="h1">{foreach from=$categoryWords item=word name=words}{if $smarty.foreach.words.first}<b>{$word}</b>{else}{$word}{/if} {/foreach}</h2>
      {if $category.description}
        <div class="category-description">
          {$category.description nofilter}
        </div>
      {/if}
    </div>
  </div>
{/block}

{*{block name='product_list_subcategories'}*}
  {*{if isset($subcategories) && $subcategories}*}
    {*<!-- Subcategories -->*}
    {*<div id="subcategories" class="u-carousel uc-el-subcategories-items uc-nav">*}
      {*<div class="row">*}
        {*{foreach from=$subcategories item=subcategory}*}
          {*<article class="subcategories-items col-4 col-lg-3 col-xxl-2">*}
            {*<div class="product-thumbnail text-center">*}
              {*<a href="{$subcategory.url}" title="{$subcategory.name}">*}
                {*{if $subcategory.id_image}*}
                  {*<img class="img-fluid" src="{$subcategory.image.medium.url}" alt="{$subcategory.image.legend}">*}
                {*{/if}*}
              {*</a>*}
            {*</div>*}
            {*<a class="subcategory-name" href="{$subcategory.url}">{$subcategory.name|truncate:20:'...'}</a>*}
          {*</article>*}
        {*{/foreach}*}
      {*</div>*}
    {*</div>*}
    {*<hr class="mt-4 mb-4">*}
  {*{/if}*}
{*{/block}*}
