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
{block name='address_block_item'}
  <article id="address-{$address.id}" class="address-item" data-id-address="{$address.id}">
    <header class="address-header">
      <h4>{$address.alias}</h4>
      <address>{$address.formatted nofilter}</address>
    </header>
    <hr>
    {block name='address_block_item_actions'}
      <footer class="address-footer">
        <a class="btn-link" href="{url entity=address id=$address.id}" data-link-action="edit-address">
          <i class="fa fa-pencil-square mr-1" aria-hidden="true"></i>
          <span>{l s='Update' d='Shop.Theme.Actions'}</span>
        </a>
        <a class="btn-link" href="{url entity=address id=$address.id params=['delete' => 1, 'token' => $token]}" data-link-action="delete-address">
          <i class="fa fa-trash-o mr-1" aria-hidden="true"></i>
          <span>{l s='Delete' d='Shop.Theme.Actions'}</span>
        </a>
      </footer>
    {/block}
  </article>
{/block}
