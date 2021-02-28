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
  <div id="search_filters">
    {block name='facets_title'}
      <h4 class="h4 d-md-none">{l s='Filter By' d='Shop.Theme.Actions'}</h4>
    {/block}
    <div id="js-active-search-filters-duplicate" class="active_filters d-md-none"></div>
    {block name='facets_clearall_button'}
      <button data-search-url="{$clear_all_link}" class="js-search-filters-clear-all d-md-none mb-3 mt-1 m-md-0">
        <i class="linearicons-cross right-space" aria-hidden="true"></i>
        <span>{l s='Clear all' d='Shop.Theme.Actions'}</span>
      </button>
    {/block}

    <div class="row">
      {foreach from=$facets item="facet"}
        {if $facet.displayed}
          <section class="facet col-12 col-md">
            <h1 class="h4 facet-title d-none d-md-block">{$facet.label}</h1>
            {assign var=_expand_id value=10|mt_rand:100000}
            {assign var=_collapse value=true}
            {foreach from=$facet.filters item="filter"}
              {if $filter.active}{assign var=_collapse value=false}{/if}
            {/foreach}
            <h1 class="h5 facet-title d-md-none{if $_collapse} collapsed{/if}" data-target="#facet_{$_expand_id}" data-toggle="collapse"{if !$_collapse} aria-expanded="true"{/if}>
              <span>{$facet.label}</span>
              <i class="fa fa-angle-down ml-1" aria-hidden="true"></i>
            </h1>
              {if $facet.widgetType !== 'dropdown'}

                {block name='facet_item_other'}
                  <ul id="facet_{$_expand_id}" class="facet-list collapse d-md-block{if !$_collapse} show{/if}">
                    {foreach from=$facet.filters key=filter_key item="filter" name="filter"}
                      {if $smarty.foreach.filter.iteration == 5}<li class="nested-list"><ul id="show_{$_expand_id}" class="collapse{if !$_collapse} show{/if}">{/if}
                        {if $filter.displayed}
                          <li>
                            {if $facet.multipleSelectionAllowed}
                              <div class="custom-control custom-checkbox">
                                <input
                                  id="facet_input_{$_expand_id}_{$filter_key}"
                                  class="custom-control-input"
                                  data-search-url="{$filter.nextEncodedFacetsURL}"
                                  type="checkbox"
                                  {if $filter.active } checked {/if}
                                >
                                <label class="facet-label custom-control-label{if isset($filter.properties.color) || isset($filter.properties.texture)} custom-control-color{/if}{if $filter.active} active{/if}" for="facet_input_{$_expand_id}_{$filter_key}">
                                  {if isset($filter.properties.color) || isset($filter.properties.texture)}<em{if isset($filter.properties.color)} style="background-color:{$filter.properties.color}"{/if}{if isset($filter.properties.texture)} style="background-image:url({$filter.properties.texture})"{/if}></em>{/if}
                                  <span {if !$js_enabled}class="ps-shown-by-js"{/if}>
                                      <a href="{$filter.nextEncodedFacetsURL}" class="search-link js-search-link" rel="nofollow">
                                        {$filter.label}
                                      </a>
                                    </span>
                                </label>
                                {if $filter.magnitude}
                                  <span class="magnitude">{$filter.magnitude}</span>
                                {/if}
                              </div>
                            {else}
                              <div class="custom-control custom-radio">
                                <input
                                  id="facet_input_{$_expand_id}_{$filter_key}"
                                  class="custom-control-input"
                                  data-search-url="{$filter.nextEncodedFacetsURL}"
                                  type="radio"
                                  name="filter {$facet.label}"
                                  {if $filter.active } checked {/if}
                                >
                                <label class="facet-label custom-control-label{if $filter.active} active{/if}" for="facet_input_{$_expand_id}_{$filter_key}">
                                  <span {if !$js_enabled}class="ps-shown-by-js"{/if}>
                                    <a href="{$filter.nextEncodedFacetsURL}" class="search-link js-search-link" rel="nofollow">
                                      {$filter.label}
                                    </a>
                                  </span>
                                </label>
                                {if $filter.magnitude}
                                  <span class="magnitude">{$filter.magnitude}</span>
                                {/if}
                              </div>
                            {/if}

                          </li>
                        {/if}
                      {if $smarty.foreach.filter.last && $smarty.foreach.filter.iteration > 4}
                        </ul>
                        <div class="text-right">
                          <a class="show-more-link{if $_collapse} collapsed{/if}" data-toggle="collapse" href="#show_{$_expand_id}" role="button" aria-expanded="false" aria-controls="collapseExample">
                            <span class="more">{l s='Show more' d='Shop.Theme.Actions'}</span>
                            <span class="hide">{l s='Hide' d='Shop.Theme.Actions'}</span>
                          </a>
                        </div>
                        </li>
                      {/if}
                    {/foreach}
                  </ul>
                {/block}

              {else}

                {block name='facet_item_dropdown'}
                  <ul id="facet_{$_expand_id}" class="facet-list collapse{if !$_collapse} in{/if} d-md-block">
                    <li>
                      <div class="facet-dropdown dropdown">
                        <button class="custom-select" rel="nofollow" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          {$active_found = false}
                          {foreach from=$facet.filters item="filter"}
                            {if $filter.active}
                              {$filter.label}
                              {if $filter.magnitude}
                                ({$filter.magnitude})
                              {/if}
                              {$active_found = true}
                            {/if}
                          {/foreach}
                          {if !$active_found}
                            {l s='(no filter)' d='Shop.Theme.Global'}
                          {/if}
                        </button>
                        <div class="dropdown-menu">
                          {foreach from=$facet.filters item="filter"}
                            {if !$filter.active}
                              <a
                                rel="nofollow"
                                href="{$filter.nextEncodedFacetsURL}"
                                class="select-list js-search-link dropdown-item"
                              >
                                {$filter.label}
                                {if $filter.magnitude}
                                  ({$filter.magnitude})
                                {/if}
                              </a>
                            {/if}
                          {/foreach}
                        </div>
                      </div>
                    </li>
                  </ul>
                {/block}

              {/if}
          </section>
        {/if}
      {/foreach}
    </div>
  </div>
