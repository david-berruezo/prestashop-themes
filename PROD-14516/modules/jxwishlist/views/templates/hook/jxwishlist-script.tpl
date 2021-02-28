{*
* 2002-2018 Zemez
*
* JX Wishlist
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

<script>
  {if $wishlists}
    {foreach from=$wishlists item=wishlist name=wishlist}
      window.fbAsyncInit = function() {
        FB.init({
          appId      : "{$jx_wishlist_app_id|escape:'html':'UTF-8'}",
          xfbml      : true,
          version    : 'v2.6'
        });
      };

      (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {
          return;
        }
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
      }(document, 'script', 'facebook-jssdk'));

      $(document).on('click', '#share_button_{$wishlist.id_wishlist|escape:'htmlall':'UTF-8'}', function(e) {
        var id_wishlist = $(this).parent().parent().find('input[name="id_wishlist"]').attr('value'),
            name_wishlist = $(this).parent().parent().find('input[name="name_wishlist"]').attr('value'),
            id_layout = $(this).parent().find('input[name="id_layout"]').attr('value'),
            id_product = $(this).parent().find('input[name="selected_products"]').attr('value');

          $.ajax({
            type:'POST',
            url: mywishlists_url,
            headers: {literal}{"cache-control": "no-cache"}{/literal},
            dataType: 'json',
            async:false,
            data: {
              myajax: 1,
              id_layout: id_layout,
              id_wishlist: id_wishlist,
              name_wishlist: name_wishlist,
              id_product: id_product,
              action: 'getImageById',
            },
            success: function(msg){
              result = msg.status;
            }
          });

          var obj = {
             method: 'share',
             title: "{$wishlist.name|truncate:30:'...'|escape:'html':'UTF-8'}",
             href: "{$link->getModuleLink('jxwishlist', 'wishlist', ['token' => $wishlist.token])|escape:'htmlall':'UTF-8'}",
             picture: "{$img_path|escape:'htmlall':'UTF-8'}{$wishlist.id_wishlist|truncate:30:'...'|escape:'html':'UTF-8'}-wishlist.jpg?v={sha1(md5(time()))|escape:'htmlall':'UTF-8'}",
          };

          function callback() {
            location.reload();
          }

          FB.ui(obj, callback);
          e.stopPropagation();
          $.magnificPopup.close();
        });
    {/foreach}
  {/if}
</script>
