/*
 * 2002-2018 Zemez
 *
 * JX Header Account
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

function in_array(value, array) {
  for (var i in array)
    if ((array[i] + '') === (value + ''))
      return true;
  return false;
}

let jxha = {
  getQueryParameters: function (query) {
    var post = new Array();
    for (var i = 0; i < query.length; i++) {
      post[query[i]['name']] = query[i]['value'];
    }
    return post;
  },
  ajax: function () {
    this.init = function (options) {
      this.options = $.extend(this.options, options);
      this.request();

      return this;
    };

    this.error = function (XMLHttpRequest, textStatus, errorThrown) {
      var error = "TECHNICAL ERROR: unable to load form.\n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
      $('body').append('<div id="jxha-modal-error" class="modal fade" tabindex="-1" role="dialog"><div class="modal-dialog" role="document"><div class="modal-content"><div class="modal-header"><button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="linearicons-cross" aria-hidden="true"></span></button></div><div class="modal-body">' + error + '</div></div></div></div>');
      $('#jxha-modal-error').modal();
    };

    this.options = {
      type: 'POST',
      url: prestashop.urls.base_url,
      cache: false,
      dataType: "json",
      success: function () {
      },
      error: this.error
    };

    this.request = function () {
      $.ajax(this.options);
    };
  },
  init: function (type) {
    if (type == 'popup' || type == 'leftside' || type == 'rightside') {
      $('body').append($('#jxha-modal'));
      $(document).on('click', '#jx-header-account-link', function () {
        $('#jxha-modal').modal();
      })
    }
    return this;
  }
};

$(document).ready(function () {
  var jxheaderaccount = new jxha.init(JXHEADERACCOUNT_DISPLAY_TYPE);

  $(document).on('submit', '[id*="login-content-"] form', function (e) {
    e.preventDefault();
    submitLoginFunction($(this).closest('.login-content'));
  });
  $(document).on('submit', '[id*="create-account-content-"] form', function (e) {
    e.preventDefault();
    submitCreate($(this).closest('.create-account-content'));
  });
  $(document).on('submit', '[id*="forgot-password-content-"] form', function (e) {
    e.preventDefault();
    submitRetrieve($(this).closest('.forgot-password-content'));
  });

  $('.header-login-content a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    $(e.target).removeClass('active');
  })
});

function submitLoginFunction(elem) {
  var options = {
    data: {
      fc: 'module',
      module: 'jxheaderaccount',
      controller: 'auth',
      submitLogin: 1,
      ajax: true,
      email: elem.find('[name=email]').val(),
      password: elem.find('[name=password]').val(),
      token: prestashop.token
    },
    success: function (jsonData) {
      if (jsonData.hasError) {
        var errors = '';
        var error;
        for (error in jsonData.errors) {
          if (error != 'indexOf' && error != '' && error != 'back') {
            if (jsonData.errors[error] == '') {
              elem.find('[name=' + error + ']').parents('.form-group').removeClass('has-error');
              elem.find('[name=' + error + ']').parents('.form-group').find('.help-block').remove();
            } else {
              elem.find('[name=' + error + ']').parents('.form-group').addClass('has-error');
              elem.find('[name=' + error + ']').parents('.form-group').find('.help-block').remove();
              elem.find('[name=' + error + ']').parent().append('<div class="help-block"><ul><li class="alert alert-danger">' + jsonData.errors[error] + '</li></ul></div>');
            }
          } else if (error == '') {
            if (jsonData.errors[error] == '') {
              elem.find('.main-help-block ul').html('')
            } else {
              elem.find('.main-help-block ul').html('<li class="alert alert-danger">' + jsonData.errors[error] + '</li>');
            }
          }
        }
      } else {
        document.location.reload();
      }
    }
  };
  var ajax = new jxha.ajax();
  ajax.init(options);
}

function submitCreate(elem) {
  var options = {
    data: $.extend({}, jxha.getQueryParameters(elem.find('form').serializeArray()), {
      submitCreate: 1,
      fc: 'module',
      module: 'jxheaderaccount',
      controller: 'auth',
      ajax: true
    }),
    success: function (jsonData) {
      if (jsonData.hasError) {
        var errors = '';
        var error;
        for (error in jsonData.errors) {
          if (error != 'indexOf' && error != '' && error != 'back') {
            if (jsonData.errors[error] == '') {
              elem.find('[name=' + error + ']').parents('.form-group').removeClass('has-error');
              elem.find('[name=' + error + ']').parents('.form-group').find('.help-block').remove();
            } else {
              elem.find('[name=' + error + ']').parents('.form-group').addClass('has-error');
              elem.find('[name=' + error + ']').parents('.form-group').find('.help-block').remove();
              elem.find('[name=' + error + ']').parent().append('<div class="help-block"><ul><li class="alert alert-danger">' + jsonData.errors[error] + '</li></ul></div>');
            }
          } else if (error == '') {
            if (jsonData.errors[error] == '') {
              elem.find('.main-help-block ul').html('')
            } else {
              elem.find('.main-help-block ul').html('<li class="alert alert-danger">' + jsonData.errors[error] + '</li>');
            }
          }
        }
      } else {
        document.location.reload();
      }
    },
    error: function (jsonData) {
      elem.find('[name=email]').parents('.form-group').addClass('has-error');
      elem.find('[name=email]').parents('.form-group').find('.help-block').remove();
      elem.find('[name=email]').parent().append('<div class="help-block"><ul><li class="alert alert-danger">' + jsonData.responseText + '</li></ul></div>');
    }
  };
  var ajax = new jxha.ajax();
  ajax.init(options);
}

function submitRetrieve(elem) {
  var options = {
    data: {
      retrievePassword: 1,
      fc: 'module',
      module: 'jxheaderaccount',
      controller: 'password',
      ajax: true,
      email: elem.find('[name=email]').val()
    },
    success: function(jsonData)
    {
      if (jsonData.hasError)
      {
        var errors = '';
        var error;
        for(error in jsonData.errors)
          if(error != 'indexOf')
            errors += '<li class="alert alert-danger">' + jsonData.errors[error] + '</li>';
        elem.find('.main-help-block ul').html(errors);
      } else {
        elem.find('.main-help-block ul').html('<li class="alert alert-success">' + jsonData.confirm + '</li>');
      }
    }
  };
  var ajax = new jxha.ajax();
  ajax.init(options);
}
