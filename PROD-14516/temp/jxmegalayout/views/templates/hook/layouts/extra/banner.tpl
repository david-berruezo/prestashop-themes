{**
* 2002-2018 Zemez
*
* JX Mega Layout
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
*  @author    Zemez (Alexander Grosul & Alexander Pervakov)
*  @copyright 2002-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div class="jxml-banner{if $content.specific_class} {$content.specific_class}{/if}{if $item.specific_class && (isset($nested) && $nested)}{else} {$item.specific_class}{/if}">
  {if $content.link}
    <a class="jxml-banner-link" href="{$content.link}" title="{$content.name}">
  {/if}
    {if $content.img}
      <img class="jxml-banner-img img-fluid" src="{$img_path}{$content.img}" alt="{$content.name}" title="{$content.name}">
    {/if}
    {if $content.content}
      <div class="jxml-banner-description">
        {$content.content nofilter}
      </div>
    {/if}
  {if $content.link}
    </a>
  {/if}
</div>