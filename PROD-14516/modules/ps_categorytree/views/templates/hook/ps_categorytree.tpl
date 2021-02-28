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

{function name="categories" nodes=[] depth=0}
  {strip}
    {if $nodes|count}
      <ul class="list-default">
        {foreach from=$nodes item=node}
          <li data-depth="{$depth}">
            <a href="{$node.link}">{$node.name}</a>
            {if $node.children}
              <span class="arrows collapsed" data-toggle="collapse" data-target="#exCollapsingNavbar{$node.id}">
                <i class="fa fa-angle-down arrow-right" aria-hidden="true"></i>
              </span>
              <div class="collapse" id="exCollapsingNavbar{$node.id}">
                {categories nodes=$node.children depth=$depth+1}
              </div>
            {/if}
          </li>
        {/foreach}
      </ul>
    {/if}
  {/strip}
{/function}

{if $categories.children}
  <div class="block-categories">
    <h3 class="h6 d-none d-sm-block">{l s='Categories' d='Shop.Theme.Global'}</h3>
    <h3 class="h4 d-flex justify-content-between align-items-center collapsed d-sm-none" data-target="#category-tree" data-toggle="collapse">
      {l s='Categories' d='Shop.Theme.Global'}
      <i class="fa fa-angle-down" aria-hidden="true"></i>
    </h3>
    <div id="category-tree" class="collapse d-sm-block">
      {categories nodes=$categories.children}
    </div>
  </div>
{/if}
