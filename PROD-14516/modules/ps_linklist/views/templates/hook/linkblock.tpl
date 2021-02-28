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
{foreach $linkBlocks as $linkBlock}
  {if $linkBlock.hook == 'displayTop' || $linkBlock.hook == 'displayNav1' || $linkBlock.hook == 'displayNav2'}
    <div id="_desktop_links_toggle">
      <ul class="links-block inline-list">
        {foreach $linkBlock.links as $link}
          <li>
            <a
              id="{$link.id}-{$linkBlock.id}"
              class="{$link.class} header-nav-links"
              href="{$link.url}"
              title="{$link.description}">
              {$link.title}
            </a>
          </li>
        {/foreach}
      </ul>
    </div>
  {elseif $linkBlock.hook == 'displayFooterBefore'}
    <div class="link-block">
      <ul class="list-inline">
        {foreach $linkBlock.links as $link}
          <li class="list-inline-item">
            <a
              id="{$link.id}-{$linkBlock.id}"
              class="{$link.class}"
              href="{$link.url}"
              title="{$link.description}">
              {$link.title}
            </a>
          </li>
        {/foreach}
      </ul>
    </div>
  {else}
    <div class="link-block">
      <h3 class="h6 d-none d-sm-block">{$linkBlock.title}</h3>
      {assign var=_expand_id value=10|mt_rand:100000}
      <h3 class="h4 d-flex justify-content-between align-items-center collapsed d-sm-none" data-target="#link_block_{$_expand_id}" data-toggle="collapse">
        {$linkBlock.title}
        <i class="fa fa-angle-down" aria-hidden="true"></i>
      </h3>
      <ul id="link_block_{$_expand_id}" class="list-default collapse d-sm-block">
        {foreach $linkBlock.links as $link}
          <li>
            <a
                id="{$link.id}-{$linkBlock.id}"
                class="{$link.class}"
                href="{$link.url}"
                title="{$link.description}">
              {$link.title}
            </a>
          </li>
        {/foreach}
      </ul>
    </div>
  {/if}
{/foreach}
