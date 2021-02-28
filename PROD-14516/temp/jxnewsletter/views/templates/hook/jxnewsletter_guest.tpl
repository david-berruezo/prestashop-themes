{*
* 2017-2018 Zemez
*
* JX Newsletter
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
* @author     Zemez (Alexander Grosul)
* @copyright  2017-2018 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<div id="newsletter_popup" class="jxnewsletter">
  <div class="jxnewsletter-inner">
    <div class="jxnewsletter-close linearicons-cross"></div>
    <div class="jxnewsletter-header">
      <h3>{$title|escape:'htmlall':'UTF-8'}</h3>
    </div>
    <div class="jxnewsletter-content">
      <div class="status-message"></div>
      <div class="description">{$content|escape:'quotes':'UTF-8'}</div>
      <div class="input-group input-group-lg">
        <input class="form-control" placeholder="{l s='Enter your e-mail'  mod='jxnewsletter'}" type="email" name="email" />
        <span class="input-group-btn jxnewsletter-submit">
          <input name="submitNewsletter" type="submit" value="" hidden>
          <i class="fa fa-paper-plane"></i>
        </span>
      </div>
      {if isset($id_module)}
        {hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}
      {/if}
    </div>
  </div>
</div>