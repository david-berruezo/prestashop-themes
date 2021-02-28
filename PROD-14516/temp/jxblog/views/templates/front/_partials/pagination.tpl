{*
* 2017 Zemez
*
* JX Blog
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
*  @author    Zemez (Alexander Grosul)
*  @copyright 2017 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<nav class="pagination row">
  <div class="showing col-md-4">
    {l s='Showing %from%-%to% of %total% item(s)' d='Shop.Theme.Catalog' sprintf=['%from%' => $pagination.from ,'%to%' => $pagination.to, '%total%' => $pagination.total]}
  </div>
  <div class="col-md-8 text-right">
    {if isset($pagination.steps) && $pagination.steps}
      <ul class="page-list">
        {foreach from=$pagination.steps item='step'}
          <li {if $step.active}class="current"{/if}>
            {if !$step.active}
              <a href="{$step.url}">
            {/if}
              {$step.name}
            {if !$step.active}
              </a>
            {/if}
          </li>
        {/foreach}
      </ul>
    {/if}
  </div>
</nav>
