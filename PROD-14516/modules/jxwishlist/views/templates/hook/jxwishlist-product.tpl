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

{if isset($wishlists)}
  {foreach from=$wishlists item=wishlist name=wishlist}
    {assign var='productsAdd' value=ClassJxWishlist::getProductByIdWishlist($wishlist.id_wishlist)}
    {foreach from=$productsAdd item=productAdd name=productAdd}
      {if $productAdd.id_product == $id_product}
        {assign var='productSelected' value=true}
        {break}
      {/if}
    {/foreach}
    {if isset($productSelected)}{break}{/if}
  {/foreach}
{/if}

{if isset($wishlists)}
  {if $wishlists|count == 1 || $wishlists|count == 0}
    <a href="#" id="wishlist_button_nopop" class="wishlist-button wishlist-btn{if isset($productSelected)} added-to-wishlist{/if}" onclick="AddProductToWishlist(event, 'action_add', '{$id_product|intval}', '{$product.name|escape:'quotes':'UTF-8'}', '{$product.id_product_attribute}', document.getElementById('quantity_wanted').value); return false;" rel="nofollow"  title="{l s='Add to my wishlist' mod='jxwishlist'}">
      <i class="linearicons-heart" aria-hidden="true"></i>
    </a>
  {else}
    <div class="dropup wishlist-btn{if isset($productSelected)} added-to-wishlist{/if}">
      <a href="#" id="wishlist_button" class="wishlist-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" title="{l s='Wishlist' mod='jxwishlist'}">
        <i class="linearicons-heart" aria-hidden="true"></i>
      </a>
      <div class="dropdown-menu content-wishlist">
        <div class="title">{l s='Wishlist' mod='jxwishlist'}</div>
        {foreach from=$wishlists item=wishlist  name=cl}
          <div class="wishlist-item" title="{$wishlist.name|escape:'html':'UTF-8'}" value="{$wishlist.id_wishlist|escape:'htmlall':'UTF-8'}" onclick="AddProductToWishlist(event, 'action_add', '{$id_product|intval}', '{$product.name|escape:'quotes':'UTF-8'}', '{$product.id_product_attribute}', document.getElementById('quantity_wanted').value, '{$wishlist.id_wishlist|intval}');">
            {l s='Add to %s' sprintf=[$wishlist.name] mod='jxwishlist'}
          </div>
        {/foreach}
      </div>
    </div>
  {/if}
{else}
  <a href="#" id="wishlist_button_nopop" class="wishlist-button wishlist-btn" onclick="AddProductToWishlist(event, 'action_add', '{$id_product|intval}', '{$product.name|escape:'quotes':'UTF-8'}', '{$product.id_product_attribute}', document.getElementById('quantity_wanted').value); return false;" rel="nofollow"  title="{l s='Add to my wishlist' mod='jxwishlist'}">
    <i class="linearicons-heart" aria-hidden="true"></i>
  </a>
{/if}