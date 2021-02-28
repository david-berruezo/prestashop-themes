/*
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

 * @author     Zemez
 * @copyright  2002-2018 Zemez
 * @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */

;(function($, window, document, underfined) {
  var pluginName = 'hotSpot',
    defaults = {
      items : []
    };

  function addItem(item, $e)
  {
    var spot = $('<div>', {
        class : 'point',
        'data-toggle': "popover"
      }), placement = 'right';

    if (item.coordinates.x > 50) {
      placement = 'left';
    }

    spot.css({
      position : 'absolute',
      'left' : item.coordinates.x+'%',
      'top' : item.coordinates.y+'%'
    }).appendTo($e).popover({
      html : true,
      sanitize: false,
      content: item.content,
      placement : placement
    });

    if (item.id_spot) {
      spot.attr('data-point-id', item.id_spot);
      $('<a>', {
        href: '#',
        class : 'delete-point',
        html: '<i class="process-icon-cancel"></i>'
      }).appendTo(spot);
    }
  }

  function HotSpot(elem, options, selector) {
    this.elem = elem;
    this.$img = $('>img', elem);
    this.selector = selector;
    this.options = $.extend({}, defaults, options || {});
    this.options.items = defaults.items.concat(options.items);
    this.pagesNum = 0;
    this.loading = false;
    this._defaults = defaults;
    this._name = pluginName;
    return this.init();
  }

  HotSpot.prototype.init = function() {
    var i,
      e = this.elem,
      $e = $(e),
      $i = this.$img,
      o = this.options;
    for (i = 0; i < o.items.length; i++) {
      addItem(o.items[i], $e);
    }
  };
  $.fn[pluginName] = function(options) {
    var selector = this.selector;
    return this.each(function() {
      if (!$.data(this, 'plugin_' + pluginName)) {
        $.data(this, 'plugin_' + pluginName, new HotSpot(this, options, selector));
      }
    });
  }
})(jQuery, window, document);
