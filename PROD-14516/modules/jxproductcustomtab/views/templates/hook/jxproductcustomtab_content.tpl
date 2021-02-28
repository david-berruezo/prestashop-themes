{*
* 2002-2018 Zemez
*
* JX Product Custom Tab
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

{if isset($items) && $items}
  {foreach from=$items item=item name=item}
    {if isset($item.name) && $item.name}
      <div id="tab-{$item.id_tab|escape:'htmlall':'UTF-8'}" class="row">
        <div class="tab-title col-12 col-lg-3 col-xl-4">
          <a class="h4 collapsed" data-toggle="collapse" href="#tab-{$item.id_tab|escape:'htmlall':'UTF-8'}-collapse" role="button" aria-expanded="false">{$item.name}</a>
        </div>
        <div id="tab-{$item.id_tab|escape:'htmlall':'UTF-8'}-collapse" class="collapse col-12 col-lg-8 col-xl-7 offset-lg-1">{$item.description nofilter}</div>
      </div>
    {/if}
  {/foreach}
{/if}