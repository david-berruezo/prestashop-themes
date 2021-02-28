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
    <div class="facet-container">
      {foreach from=$facets item="facet"}
        {if $facet.displayed}
          <section class="facet">
            {assign var=_expand_id value=10|mt_rand:100000}
            <h1 class="h6 facet-title" id="#facet_{$_expand_id}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <span>{$facet.label}</span>
              <i class="fa fa-angle-down ml-1" aria-hidden="true"></i>
            </h1>
              {if $facet.widgetType !== 'dropdown'}

                {block name='facet_item_other'}
                  <div class="dropdown-menu" aria-labelledby="facet_{$_expand_id}">
                    <ul class="facet-list">
                      {foreach from=$facet.filters key=filter_key item="filter"}
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
                      {/foreach}
                    </ul>
                  </div>
                {/block}

              {else}

                {block name='facet_item_dropdown'}
                  <div class="dropdown-menu" aria-labelledby="facet_{$_expand_id}">
                    <ul class="facet-list">
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
                  </div>
                {/block}

              {/if}
          </section>
        {/if}
      {/foreach}
    </div>
  </div>
