<div class="images-list-block">
    <a class="prev-img" data-id-product="{$id_product|escape:'html':'UTF-8'}"><i class="material-icons">keyboard_arrow_left</i></a>
    <ul class="list-images">
        {foreach $images as $key => $image}
            <li  class="image-item {if $key == 0} first {/if} {if $count_images == ($key+1) } last {/if} {if $cover == $image} selected{/if}" data-href="{$image|escape:'html':'UTF-8'}"></li>
        {/foreach}
    </ul>
    <a class="next-img" data-id-product="{$id_product|escape:'html':'UTF-8'}"><i class="material-icons">keyboard_arrow_right</i></a>
</div>