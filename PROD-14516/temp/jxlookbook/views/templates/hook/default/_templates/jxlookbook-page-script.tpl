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
{foreach from=$tabs item=tab name=tab}
  {if isset($tab.hotspots)}
    <script>
      {literal}
      $(document).ready(function () {
        //'window.addEventListener('load', function () {
        var items = [
          {/literal}
          {foreach from=$tab.hotspots item=hotspot}
          {assign var=name value=$hotspot.name}
          {assign var=description value=$hotspot.description}
          {assign var=type value=$hotspot.type}
          {if $type == 1}
          {assign var=products value=$hotspot.product}
          {/if}
          {assign var=content value={include './../tooltip.tpl'}}
          {literal}
          {
            content: '{/literal}{$content|escape:'javascript':'UTF-8' nofilter}{literal}',
            coordinates: {/literal}{$hotspot.coordinates nofilter}{literal}
          },
          {/literal}
          {/foreach}
          {literal}
        ];
        $('.hotSpotWrap_{/literal}{$tab.id_tab|escape:'htmlall':'UTF-8'}_{$smarty.foreach.tab.iteration|escape:'htmlall':'UTF-8'}{literal}').hotSpot({
          items: items
        });
      });
      {/literal}
    </script>
  {/if}
{/foreach}
<script>
  $(document).ready(function () {
    $('.point[data-toggle=popover]').on('shown.bs.popover', function () {
      var $t = $(this);
      $t.addClass('active');
      $('.popover-close').on('click', function (e) {
        $(e.target).closest('.popover').popover('hide');
      });
    });

    $('.point[data-toggle=popover]').on('hide.bs.popover', function () {
      $(this).removeClass('active');
    });
  });
</script>