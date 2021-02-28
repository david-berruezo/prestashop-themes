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
<div class="language-selector js-dropdown">
  <span class="label">{l s='Language' d='Shop.Theme.Global'}</span>
  <span data-toggle="dropdown" class="d-none d-md-inline-block text-capitalize" aria-haspopup="true" aria-expanded="false" aria-label="{l s='Language dropdown' d='Shop.Theme.Global'}">
    {foreach from=$languages item=language}{if $language.id_lang == $current_language.id_lang}{$language.iso_code}{/if}{/foreach}<i class="fa fa-angle-down ml-1" aria-hidden="true"></i>
  </span>
  <div class="dropdown-menu dropdown-menu-right" aria-labelledby="language-selector-label">
    {foreach from=$languages item=language}
      <a href="{url entity='language' id=$language.id_lang}" class="dropdown-item{if $language.id_lang == $current_language.id_lang} active{/if}">{$language.name_simple}</a>
    {/foreach}
  </div>
  <div id="_desktop_language_selector">
    <p id="language-selector-label" class="d-md-none">{l s='Language:' d='Shop.Theme.Global'}</p>
    <select class="custom-select select-primary link d-md-none" aria-labelledby="language-selector-label">
      {foreach from=$languages item=language}
        <option value="{url entity='language' id=$language.id_lang}"{if $language.id_lang == $current_language.id_lang} selected="selected"{/if}>{$language.name_simple}</option>
      {/foreach}
    </select>
  </div>
</div>
