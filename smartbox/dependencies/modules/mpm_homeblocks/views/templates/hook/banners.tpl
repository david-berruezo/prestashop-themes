
<section class="homeBanner">
    <ul class="homeBannerContent" >
        {foreach $settings as $value}
            <li data-position="{$value['position_description']|escape:'htmlall':'UTF-8'}" class="item_block_{$value['id_homeblocks']|escape:'htmlall':'UTF-8'}" style=' width: {$value['width']|escape:'htmlall':'UTF-8'}%;'>
                <div class="item_block_img">
                    <a {if isset($value['link']) && $value['link']}href="{$value['link']|escape:'htmlall':'UTF-8'}" {/if}><img alt=" " src="{$value['image']|escape:'htmlall':'UTF-8'}"></a>
                </div>
                <div class="item_block_content">
                    {$value['description']|escape:'htmlall':'UTF-8' nofilter}
                </div>
            </li>
        {/foreach}
    </ul>

</section>