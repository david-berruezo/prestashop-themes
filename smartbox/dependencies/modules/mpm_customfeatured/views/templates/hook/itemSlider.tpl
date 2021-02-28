{if isset($tabs) && $tabs && $products}

    <div class="mpm_customfeatured">


        <div class="customfeatured_block">
            <input type="hidden" name="basePath" value="{$basePath|escape:'htmlall':'UTF-8'}">
            <input type="hidden" name="id_shop" value="{$id_shop|escape:'htmlall':'UTF-8'}">
            <input type="hidden" name="id_lang" value="{$id_lang|escape:'htmlall':'UTF-8'}">
            <ul class="block_home_featured">
                {foreach $tabs as $key => $tab}
                    <li data-tab="{$tab['id_customfeatured']|escape:'htmlall':'UTF-8'}" class="tab_featured {if $key == 0} active{/if}">{$tab['title']|escape:'htmlall':'UTF-8'}</li>
                {/foreach}
                <li style="clear: both"></li>
            </ul>
        </div>


        <div class="home_featured_product_list block_featured_slider ">
            <div class="progres_bar_featured"><div class="loading"><div></div></div></div>
            <div class="customfeatured_slider">
                {foreach $products as $key => $product}
                    {include file='catalog/_partials/miniatures/product.tpl' product=$product}
                {/foreach}
            </div>
        </div>
    </div>

{/if}