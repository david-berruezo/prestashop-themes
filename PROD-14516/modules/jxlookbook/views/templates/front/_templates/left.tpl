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
  <div class="jxlookbooks">
    {foreach from=$tabs item=tab name=tab}
      <div class="lookbook-block row" data-id="{$tab.id_tab|escape:'htmlall':'UTF-8'}">
        <div class="col-12 col-sm-6 left">
          <div class="caption">
            <h2>{$tab.name|escape:'html':'UTF-8'}</h2>
            <div>
              {$tab.description nofilter}
            </div>
          </div>
          {if isset($tab.products) && $tab.products}
            {assign var=products value=$tab.products}
            {include '../product-list.tpl'}
          {/if}
        </div>
        <div class="col-12 col-sm-6 right">
          <div class="hotSpotWrap hotSpotWrap_{$tab.id_tab|escape:'htmlall':'UTF-8'}_{$smarty.foreach.tab.iteration|escape:'htmlall':'UTF-8'}">
            <img src="{$base_url|escape:'htmlall':'UTF-8'}{$tab.image|escape:'htmlall':'UTF-8'}" style="max-width:100%" alt="">
          </div>
        </div>
      </div>
    {/foreach}
  </div>
{else}
  <div class="alert alert-warning" role="alert">
    {l s='No one tabs added'}
  </div>
{/if}