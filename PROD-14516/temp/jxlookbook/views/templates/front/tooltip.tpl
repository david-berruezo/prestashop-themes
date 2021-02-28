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
{if $type == 1}
  <i class="popover-close linearicons-cross"></i>
  {foreach from=$products item=product}
    {include './product.tpl'}
  {/foreach}
{elseif $type == 2}
  <i class="popover-close linearicons-cross"></i>
  <div class="name">{$name|escape:'htmlall':'UTF-8'}</div>
  <div class="description">{$description nofilter}</div>
{/if}
