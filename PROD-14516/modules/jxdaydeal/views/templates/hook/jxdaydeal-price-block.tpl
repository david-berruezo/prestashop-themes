{*
* 2002-2018 Zemez
*
* Zemez Deal of Day
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
*  @author    Zemez (Sergiy Sakun)
*  @copyright 2002-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if isset($daydeal_products_extra["data_end"]) && $daydeal_products_extra["data_end"]}
  {assign var='data_end' value=$daydeal_products_extra["data_end"]}

  <div class="block products_block daydeal-box">
    <h3>{l s='Time left to buy' mod='jxdaydeal'}</h3>
    <div data-countdown="{$data_end|escape:'htmlall':'UTF-8'}"></div>
  </div>
  <script type="text/javascript">
    if (typeof(runJxDayDealCounter) != 'undefined') {
      runJxDayDealCounter();
    };
  </script>
{/if}