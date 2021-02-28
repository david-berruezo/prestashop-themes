{*
* 2017-2018 Zemez
*
* JX Header Account
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

{if $f_status || $g_status || $vk_status}
  <div class="clearfix social-login-buttons">
    {if $f_status}
      <a class="btn btn-xs btn-facebook" href="{url entity='module' name='jxheaderaccount' controller='facebooklogin' params=['back' => {url entity='index'}] ssl=true}"
         title="{l s='Register with Your Facebook Account' mod='jxheaderaccount'}">
        <i class="fa fa-facebook" aria-hidden="true"></i>{l s='Register with Your Facebook Account' mod='jxheaderaccount'}
      </a>
    {/if}
    {if $g_status}
      <a class="btn btn-xs btn-google" href="{url entity='module' name='jxheaderaccount' controller='googlelogin' params=['back' => {url entity='index'}] ssl=true}"
         title="{l s='Register with Your Google Account' mod='jxheaderaccount'}">
        <i class="fa fa-google-plus" aria-hidden="true"></i>{l s='Register with Your Google Account' mod='jxheaderaccount'}
      </a>
    {/if}
    {if $vk_status}
      <a class="btn btn-xs btn-vk" href="{url entity='module' name='jxheaderaccount' controller='vklogin' params=['back' => {url entity='index'}] ssl=true}" title="{l s='Register with Your VK Account' mod='jxheaderaccount'}">
        <i class="fa fa-vk" aria-hidden="true"></i>{l s='Register with Your VK Account' mod='jxheaderaccount'}
      </a>
    {/if}
  </div>
{/if}
