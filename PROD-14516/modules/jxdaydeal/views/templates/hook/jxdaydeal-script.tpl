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

<script type="text/javascript">
  var jxdd_msg_days = "{l s='days' mod='jxdaydeal' js=1}";
  var jxdd_msg_hr = "{l s='hours' mod='jxdaydeal' js=1}";
  var jxdd_msg_min = "{l s='minutes' mod='jxdaydeal' js=1}";
  var jxdd_msg_sec = "{l s='seconds' mod='jxdaydeal' js=1}";
  runJxDayDealCounter();
  function runJxDayDealCounter() {
      $("[data-countdown]").each(function() {
          var $this = $(this), finalDate = $(this).data("countdown");
          $this.countdown(finalDate, function(event) {
              $this.html(event.strftime('<span>%D <span>'+jxdd_msg_days+'</span></span><span>%H <span>'+jxdd_msg_hr+'</span></span><span>%M <span>'+jxdd_msg_min+'</span></span><span>%S <span>'+jxdd_msg_sec+'</span></span>'));
          });
      });
  }
</script>