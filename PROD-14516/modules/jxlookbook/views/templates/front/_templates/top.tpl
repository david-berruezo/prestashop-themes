{**
* 2002-2018 Zemez
*
* JX Header Account Block
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
*  @author    Zemez
*  @copyright 2002-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}
{if count($tabs) > 0}
  <div class="row lookbook-default jx-lookbook-block">
    <div class="col-sm-12">
      {foreach from=$tabs item=tab name=tab}
        <div class=" lookbook-tab" data-id="{$tab.id_tab|escape:'htmlall':'UTF-8'}" {if $smarty.foreach.tab.iteration != 1}style="display: none"{/if}>
          <div class="row">
            <div class="col-sm-12">
              <div class="hotSpotWrap hotSpotWrap_{$tab.id_tab|escape:'htmlall':'UTF-8'}_{$smarty.foreach.tab.iteration|escape:'htmlall':'UTF-8'}">
                <img src="{$base_url|escape:'htmlall':'UTF-8'}{$tab.image|escape:'htmlall':'UTF-8'}" style="max-width:100%" alt="">
              </div>
              <div class="caption hidden">
                <h3>{$tab.name|escape:'html':'UTF-8'}</h3>
                <p>{$tab.description nofilter}</p>
              </div>
            </div>
            <div class="col-sm-12">
                {if isset($tab.products) && $tab.products}
                  {assign var=products value=$tab.products}
                  {include file="../product-list.tpl"}
                {/if}
                    {if count($tabs) > 1}
                      <ul class="tab-list clearfix" style="text-align: center;">
                        {foreach from=$tabs item=tab_l name=tab_l}
                          <li>
                            <a href="#" data-id="{$tab_l.id_tab|escape:'html':'UTF-8'}" {if $smarty.foreach.tab_l.iteration == 1}class="active"{/if}>
                              <img src="{$base_url|escape:'htmlall':'UTF-8'}{$tab_l.image|escape:'html':'UTF-8'}" style="max-width:100%" alt="">
                            </a>
                          </li>
                        {/foreach}
                      </ul>
                    {/if}
              </div>
            </div>
          </div>
        </div>
      {/foreach}
    </div>
  </div>
{else}
  <div class="alert alert-warning" role="alert">
    {l s='No one tabs added'}
  </div>
{/if}