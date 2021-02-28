<div class="home_featured_product_list block_featured_slider ">
    <div class="progres_bar_featured"><div class="loading"><div></div></div></div>
    <div class="customfeatured_slider">
        {foreach $products as $key => $product}
            {include file='catalog/_partials/miniatures/product.tpl' product=$product}
        {/foreach}
    </div>
</div>