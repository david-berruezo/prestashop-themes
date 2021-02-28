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

<div class="block-newsletter">
  <h3 class="h6">{l s='Newsletter' d='Shop.Theme.Global'}</h3>
  <h3 class="h4 d-sm-none">{l s='Newsletter' d='Shop.Theme.Global'}</h3>
  {if $conditions}
    <p id="block-newsletter-label">{$conditions}</p>
  {/if}
  {if $msg}
    <p class="alert {if $nw_error}alert-danger{else}alert-success{/if}">
      {$msg}
    </p>
  {/if}
  <form action="{$urls.pages.index}#footer" method="post" class="mb-3">
    <div class="input-group input-group-lg">
      <input type="hidden" name="action" value="0">
      <input
        class="form-control"
        name="email"
        type="text"
        value="{$value}"
        placeholder="{l s='Your email address' d='Shop.Forms.Labels'}"
        aria-labelledby="block-newsletter-label"
      >
      <span class="input-group-btn">
        <label class="btn btn-custom-black btn-lg">
          <input name="submitNewsletter" type="submit" value="" hidden>
          <i class="fa fa-paper-plane"></i>
          <span>{l s='Subscribe' d='Shop.Theme.Actions'}</span>
        </label>
      </span>
    </div>
  </form>
  {if isset($id_module)}
    {hook h='displayGDPRConsent' id_module=$id_module}
  {/if}
</div>
