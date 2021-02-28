{**
* 2002-2018 Zemez
*
* JX Look Book
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
{if $tabs && isset($tabs)}
  <div class="product-lookbooks">
    <label>{l s='LookBooks:' mod='jxlookbook'}</label>
    <ul>
      {foreach from=$tabs item=tab name=tab}
        <li>
          <a href="{$link->getModuleLink('jxlookbook', 'jxlookbook', ['collection' => $tab.id_collection])|escape:'html':'UTF-8'}">
              {$tab.name|escape:'htmlall':'UTF-8'}{if $smarty.foreach.tab.iteration != count($tabs)},{/if}
          </a>
        </li>
      {/foreach}
    </ul>
  </div>
{/if}