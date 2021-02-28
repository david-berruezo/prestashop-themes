/**
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
 */

prestashop.cart = prestashop.cart || {};
prestashop.cart.active_inputs = null;
let spinnerSelector = 'input[name="product-quantity-spin"]';
let hasError = false;
let isUpdateOperation = false;
let errorMsg = '';

/**
 * Attach Bootstrap TouchSpin event handlers
 */
function createSpin() {
  $.each($(spinnerSelector), function(index, spinner) {
    $(spinner).TouchSpin({
      verticalbuttons: true,
      verticalup: '',
      verticaldown: '',
      verticalupclass: 'fa fa-angle-up',
      verticaldownclass: 'fa fa-angle-down',
      buttondown_class: 'btn',
      buttonup_class: 'btn',
      min: parseInt($(spinner).attr('min'), 10),
      max: 1000000
    });
  });
  CheckUpdateQuantityOperations.switchErrorStat();
}

$(document).ready(() => {
  let productLineInCartSelector = '.js-cart-line-product-quantity';
  let promises = [];
  prestashop.on('updateCart', () => {
    $('.quickview').modal('hide');
  });
  prestashop.on('updatedCart', () => {
    createSpin();
  });
  createSpin();
  let $body = $('body');

  function isTouchSpin(namespace) {
    return namespace === 'on.startupspin' || namespace === 'on.startdownspin';
  }

  function shouldIncreaseProductQuantity(namespace) {
    return namespace === 'on.startupspin';
  }

  function findCartLineProductQuantityInput($target) {
    var $input = $target.parents('.bootstrap-touchspin').find(productLineInCartSelector);
    if ($input.is(':focus')) {
      return null;
    } else {
      return $input;
    }
  }

  function camelize(subject) {
    let actionTypeParts = subject.split('-');
    let i;
    let part;
    let camelizedSubject = '';
    for (i = 0; i < actionTypeParts.length; i++) {
      part = actionTypeParts[i];
      if (0 !== i) {
        part = part.substring(0, 1).toUpperCase() + part.substring(1);
      }
      camelizedSubject = camelizedSubject + part;
    }
    return camelizedSubject;
  }

  function parseCartAction($target, namespace) {
    if (!isTouchSpin(namespace)) {
      return {
        url: $target.attr('href'),
        type: camelize($target.data('link-action'))
      }
    }
    let $input = findCartLineProductQuantityInput($target);
    if (!$input) {
      return;
    }
    let cartAction = {};
    if (shouldIncreaseProductQuantity(namespace)) {
      cartAction = {
        url: $input.data('up-url'),
        type: 'increaseProductQuantity'
      };
    } else {
      cartAction = {
        url: $input.data('down-url'),
        type: 'decreaseProductQuantity'
      }
    }
    return cartAction;
  }

  let abortPreviousRequests = () => {
    var promise;
    while (promises.length > 0) {
      promise = promises.pop();
      promise.abort();
    }
  };
  var getTouchSpinInput = ($button) => {
    return $($button.parents('.bootstrap-touchspin').find('input'));
  };
  var handleCartAction = (event) => {
    event.preventDefault();
    let $target = $(event.currentTarget);
    let dataset = event.currentTarget.dataset;
    let cartAction = parseCartAction($target, event.namespace);
    let requestData = {
      ajax: '1',
      action: 'update'
    };
    if (typeof cartAction === 'undefined') {
      return;
    }
    abortPreviousRequests();
    $.ajax({
      url: cartAction.url,
      method: 'POST',
      data: requestData,
      dataType: 'json',
      beforeSend: function(jqXHR) {
        promises.push(jqXHR);
      }
    }).then(function(resp) {
      CheckUpdateQuantityOperations.checkUpdateOpertation(resp);
      var $quantityInput = getTouchSpinInput($target);
      $quantityInput.val(resp.quantity);
      // Refresh cart preview
      prestashop.emit('updateCart', {
        reason: dataset
      });
    }).fail((resp) => {
      prestashop.emit('handleError', {
        eventType: 'updateProductInCart',
        resp: resp,
        cartAction: cartAction.type
      });
    });
  };
  $body.on(
    'click',
    '[data-link-action="delete-from-cart"], [data-link-action="remove-voucher"]',
    handleCartAction
  );
  $body.on('touchspin.on.startdownspin', spinnerSelector, handleCartAction);
  $body.on('touchspin.on.startupspin', spinnerSelector, handleCartAction);

  function sendUpdateQuantityInCartRequest(updateQuantityInCartUrl, requestData, $target) {
    abortPreviousRequests();
    return $.ajax({
      url: updateQuantityInCartUrl,
      method: 'POST',
      data: requestData,
      dataType: 'json',
      beforeSend: function(jqXHR) {
        promises.push(jqXHR);
      }
    }).then(function(resp) {
      CheckUpdateQuantityOperations.checkUpdateOpertation(resp);
      $target.val(resp.quantity);
      var dataset;
      if ($target && $target.dataset) {
        dataset = $target.dataset;
      } else {
        dataset = resp;
      }
      // Refresh cart preview
      prestashop.emit('updateCart', {
        reason: dataset
      });
    }).fail((resp) => {
      prestashop.emit('handleError', {eventType: 'updateProductQuantityInCart', resp: resp})
    });
  }

  function getRequestData(quantity) {
    return {
      ajax: '1',
      qty: Math.abs(quantity),
      action: 'update',
      op: getQuantityChangeType(quantity)
    }
  }

  function getQuantityChangeType($quantity) {
    return ($quantity > 0) ? 'up' : 'down';
  }

  function updateProductQuantityInCart(event) {
    let $target = $(event.currentTarget);
    let updateQuantityInCartUrl = $target.data('update-url');
    let baseValue = $target.attr('value');
    // There should be a valid product quantity in cart
    let targetValue = $target.val();
    if (targetValue != parseInt(targetValue) || targetValue < 0 || isNaN(targetValue)) {
      $target.val(baseValue);
      return;
    }
    // There should be a new product quantity in cart
    let qty = targetValue - baseValue;
    if (qty == 0) {
      return;
    }
    var requestData = getRequestData(qty);
    sendUpdateQuantityInCartRequest(updateQuantityInCartUrl, requestData, $target);
  }

  $body.on(
    'focusout',
    productLineInCartSelector,
    (event) => {
      updateProductQuantityInCart(event);
    }
  );
  $body.on(
    'keyup',
    productLineInCartSelector,
    (event) => {
      if (event.keyCode == 13) {
        updateProductQuantityInCart(event);
      }
    }
  );
  $body.on(
    'click',
    '.js-discount .code',
    (event) => {
      event.stopPropagation();
      var $code = $(event.currentTarget);
      var $discountInput = $('[name=discount_name]');
      $discountInput.val($code.text());
      return false;
    }
  )
});
const CheckUpdateQuantityOperations = {
  'switchErrorStat': () => {
    let $checkoutBtn = $('.checkout a');
    if ($("#notifications article.alert-danger").length
      || hasError
    ) {
      $checkoutBtn.addClass('disabled');
    }
    if (hasError && '' !== errorMsg) {
      let strError = ' <article class="alert alert-danger" role="alert" data-alert="danger"><ul><li>' + errorMsg + '</li></ul></article>';
      $('#notifications .container').html(strError);
      errorMsg = '';
      isUpdateOperation = false;
    } else if (!hasError && isUpdateOperation) {
      hasError = false;
      isUpdateOperation = false;
      $('#notifications .container').html('');
      $checkoutBtn.removeClass('disabled');
    }
  },
  'checkUpdateOpertation': (resp) => {
    hasError = resp.hasOwnProperty('hasError');
    isUpdateOperation = true;
    if (!hasError) {
      hasError = ('' !== resp.errors);
      errorMsg = resp.errors;
    }
  }
};