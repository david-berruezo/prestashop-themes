{*
* 2002-2018 Zemez
*
* Zemez Social Login
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
* @author     Zemez
* @copyright  2002-2018 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{assign var=back_page value = $link->getPageLink('index')|escape:'html':'UTF-8'}
{if $f_status || $g_status || $vk_status}
  <p class="mt-3 mb-1">{l s='Or Login with social network' mod='jxheaderaccount'}</p>
  <div class="social-login-buttons">
    {if $f_status}
      <a class="btn btn-xs btn-facebook" {if isset($back) && $back}href="{$link->getModuleLink('jxheaderaccount', 'facebooklogin', [], true)}" {else}href="{$link->getModuleLink('jxheaderaccount', 'facebooklogin', ['back' => $back_page], true)}"{/if} title="{l s='Login with Your Facebook Account' mod='jxheaderaccount'}">
        <i class="fa fa-facebook" aria-hidden="true"></i>{l s='Facebook' mod='jxheaderaccount'}
      </a>
    {/if}
    {if $g_status}
      <a class="btn btn-xs btn-google" {if isset($back) && $back}href="{$link->getModuleLink('jxheaderaccount', 'googlelogin', ['back' => $back], true)}" {else}href="{$link->getModuleLink('jxheaderaccount', 'googlelogin', ['back' => $back_page], true)}"{/if} title="{l s='Login with Your Google Account' mod='jxheaderaccount'}">
        <i class="fa fa-google-plus" aria-hidden="true"></i>{l s='Google +' mod='jxheaderaccount'}
      </a>
    {/if}
    {if $vk_status}
      <a class="btn btn-xs btn-vk" {if isset($back) && $back}href="{$link->getModuleLink('jxheaderaccount', 'vklogin', ['back' => $back], true)}" {else}href="{$link->getModuleLink('jxheaderaccount', 'vklogin', ['back' => $back_page], true)}"{/if} title="{l s='Login with Your VK Account' mod='jxheaderaccount'}">
        <i class="fa fa-vk" aria-hidden="true"></i>{l s='VK' mod='jxheaderaccount'}
      </a>
    {/if}
  </div>
{/if}