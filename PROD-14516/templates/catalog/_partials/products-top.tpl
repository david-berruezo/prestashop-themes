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
<div id="js-product-list-top" class="products-selection d-flex justify-content-between align-items-center">
  {if !empty($listing.rendered_facets)}
    <div class="d-md-none filter-button mb-1 mr-2">
      <button class="clone-slidebar-toggle btn btn-lg btn-primary only-mobile" data-id-slidebar="filter-slidebar">
        <i class="fa fa-filter right-space" aria-hidden="true"></i>
        <span>{l s='Filter' d='Shop.Theme.Actions'}</span>
      </button>
    </div>
  {/if}
  <ul id="grid-list-buttons" class="d-flex m-0 mb-1">
    <li>
      <a id="grid" class="linearicons-grid" rel="nofollow" href="#" title="{l s='Grid' d='Shop.Theme.Actions'}"></a>
    </li>
    <li>
      <a id="grid-large" class="linearicons-icons2" rel="nofollow" href="#" title="{l s='Grid large' d='Shop.Theme.Actions'}"></a>
    </li>
    <li>
      <a id="list" class="linearicons-list4" rel="nofollow" href="#" title="{l s='List' d='Shop.Theme.Actions'}"></a>
    </li>
  </ul>
  <div class="showing d-none d-lg-block mb-1">
    {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=[
    '%from%' => $listing.pagination.items_shown_from ,
    '%to%' => $listing.pagination.items_shown_to,
    '%total%' => $listing.pagination.total_items
    ]}
  </div>
  {block name='sort_by'}
    {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
  {/block}
</div>
