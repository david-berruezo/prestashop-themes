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

import $ from 'jquery';

$(document).ready(() => {
    var $body = $('body');
    let promises = [];
    let abortPreviousRequests = () => {
        var promise;
        while (promises.length > 0) {
            promise = promises.pop();
            promise.abort();
        }
    };

    $body.on('click', 'a[data-link-action="add-to-cart"]', (event) => {
        event.preventDefault();
        var $productElement = $(event.currentTarget);
        var href = $productElement.attr('href');
        var query = href.split('?')[1];
        var actionUrl = href.split('?')[0];
        $productElement.addClass('active');

        abortPreviousRequests();
        $.ajax({
            url: actionUrl,
            method: 'POST',
            data: query+'&qty=1&action=update',
            dataType: 'json',
            beforeSend: function (jqXHR) {
                promises.push(jqXHR);
            }
        }).then(function (resp) {
            if (resp.hasError) {
                prestashop.emit('handleCartError', {eventType: 'addProductToCart',response: resp.errors});
            } else {
                prestashop.emit('updateCart', {
                    reason: {
                        idProduct: resp.id_product,
                        idProductAttribute: resp.id_product_attribute,
                        linkAction: event.currentTarget.dataset.linkAction
                    }
                });
            }
            $productElement.removeClass('active');
        }).fail((resp) => {
            prestashop.emit('handleError', {eventType: 'updateShoppingCart', resp: resp});
            $productElement.removeClass('active');
        });
    });

    abortPreviousRequests();
    $(document).on('click', 'a[data-link-action="remove-from-cart"], a[data-link-action="remove-voucher"]', (event) => {
        event.preventDefault();
        var $target = $(event.currentTarget);
        var actionURL = $target.attr('href');
        var dataset = event.currentTarget.dataset;

        $.ajax({
            url: actionURL,
            method: 'POST',
            data: '&ajax=1&action=update',
            dataType: 'json',
            beforeSend: function (jqXHR) {
                promises.push(jqXHR);
            }
        }).then(function (resp) {
            prestashop.emit('updateCart', {reason: dataset});
        }).fail((resp) => {
            prestashop.emit('handleError', {eventType: 'updateShoppingCart', resp: resp});
        });
    });
});
