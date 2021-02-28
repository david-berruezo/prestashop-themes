{*
* 2002-2018 Zemez
*
* JX Mega Menu
*
* NOTICE OF LICENSE
*
* This source file is subject to the General Public License (GPL 2.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/GPL-2.0
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade the module to newer
* versions in the future.
*
* @author     Zemez (Alexander Grosul)
* @copyright  2002-2018 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if isset($original_hook_name) && $original_hook_name == 'displayNav'}
  {assign var="used_header_menu" value="true" scope="global"}
{/if}

{if isset($menu) && $menu}
  <i class="fa fa-bars icon-toggle" aria-hidden="true" data-toggle="modal" data-target="#modal-menu"></i>
  <div class="modal fade modal-close-inside" id="modal-menu" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
    <div class="modal-content">
    <button type="button" class="close linearicons-cross" data-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
    <div id="_desktop_jxmegamenu" class="modal-body pt-0">
      <h4 class="mt-3 text-left">{l s='Categories' mod='jxmegamenu'}</h4>
      <div id="click_menu" class="{$hook}_menu column_menu top-level jxmegamenu_item text-left">
        <ul class="menu clearfix list-default-lg">
          {foreach from=$menu key=id item='item'}
            <li class="{$item.specific_class}{if $item.is_simple} simple{/if} top-level-menu-li jxmegamenu_item {$item.unique_code}">
              {if $item.url}
                <a class="{$item.unique_code} top-level-menu-li-a jxmegamenu_item" href="{$item.url}">
              {else}
                <span class="{$item.unique_code} top-level-menu-li-span jxmegamenu_item">
              {/if}
                {if $item.title}{$item.title}{/if}
                  {if $item.badge}
                    <span class="menu_badge {$item.unique_code} top-level-badge jxmegamenu_item">{$item.badge}</span>
                  {/if}
              {if $item.url}
                </a>
              {else}
                </span>
              {/if}
              {if $item.is_simple}
                <ul class="is-simplemenu jxmegamenu_item first-level-menu {$item.unique_code}">
                  {if isset($item.submenu)}
                    {$item.submenu nofilter}
                  {/if}
                </ul>
              {/if}
              {if $item.is_mega}
                <div class="is-megamenu jxmegamenu_item first-level-menu {$item.unique_code}">
                  <div>
                    {if isset($item.submenu)}
                      {foreach from=$item.submenu key='id_row' item='row'}
                        <div id="megamenu-row-{$id}-{$id_row}" class="megamenu-row row megamenu-row-{$id_row}">
                          {if isset($row)}
                            {foreach from=$row item='col'}
                              <div id="column-{$id}-{$id_row}-{$col.col}" class="megamenu-col megamenu-col-{$id_row}-{$col.col} col-md-{$col.width} {$col.class}">
                                <ul class="content">
                                  {$col.content nofilter}
                                </ul>
                              </div>
                            {/foreach}
                          {/if}
                        </div>
                      {/foreach}
                    {/if}
                  </div>
                </div>
              {/if}
            </li>
          {/foreach}
        </ul>
      </div>
    </div>
    </div>
    </div>
  </div>
{/if}