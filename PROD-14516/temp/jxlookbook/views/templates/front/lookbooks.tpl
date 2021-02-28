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

{extends file=$layout}
{block name='breadcrumb'}
  <nav class="hidden-sm-down">
    <ol class="breadcrumb" itemscope itemtype="http://schema.org/BreadcrumbList">
        <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <span>
            <span itemprop="name">{l s='All LookBooks' mod='jxlookbook'}</span>
          </span>
        </li>
    </ol>
  </nav>
{/block}

{block name="content"}
{if $collections && count($collections) > 0}
<div class="jxlookbooks">
  <h2 class="text-center">{l s='LookBooks' mod='jxlookbook'}</h2>
  {foreach from=$collections item=collection}
    <a href="{$link->getModuleLink('jxlookbook', 'jxlookbook', ['collection' => $collection.id_collection])|escape:'html':'UTF-8'}" class="thumbnail">
      <img src="{$base_dir|escape:'htmlall':'UTF-8'}{$collection.image|escape:'htmlall':'UTF-8'}" alt="...">
      <div class="caption">
        <h3 class="name">{$collection.name|escape:'quotes':'UTF-8'}</h3>
        <p class="description">{$collection.description nofilter}</p>
      </div>
    </a>
  {/foreach}
</div>
{else}
  <div class="alert alert-warning" role="alert">
    {l s='No one collection added'}
  </div>
{/if}
{/block}