<div id="product-features" class="row" data-product="{$product.embedded_attributes|json_encode}">
  <div class="tab-title col-12 col-lg-3 col-xl-4">
    <a class="h4 {if $product.description} collapsed{/if}" data-toggle="collapse" href="#product-details-collapse" role="button" {if !$product.description}aria-expanded="true"{else}aria-expanded="false"{/if}>{l s='Product Details' d='Shop.Theme.Catalog'}</a>
  </div>
  <div id="product-details-collapse" class="collapse col-12 col-lg-8 col-xl-7 offset-lg-1">
    {block name='product_features'}
      {if $product.grouped_features}
        <section class="product-features">
          <dl class="data-sheet">
            {block name='product_manufacturer'}
              {if isset($product_manufacturer->id)}
                <dt class="name">{l s='Brand' d='Shop.Theme.Catalog'}</dt>
                <dd class="value"><a href="{$product_brand_url}">{$product_manufacturer->name}</a></dd>
              {/if}
            {/block}
            {foreach from=$product.grouped_features item=feature}
              <dt class="name">{$feature.name}</dt>
              <dd class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</dd>
            {/foreach}
          </dl>
        </section>
      {/if}
    {/block}

    {* if product have specific references, a table will be added to product details section *}
    {block name='product_specific_references'}
      {if isset($product.specific_references)}
        <section class="product-features">
          <h3 class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</h3>
          <dl class="data-sheet">
            {foreach from=$product.specific_references item=reference key=key}
              <dt class="name">{$key}</dt>
              <dd class="value">{$reference}</dd>
            {/foreach}
          </dl>
        </section>
      {/if}
    {/block}
  </div>
</div>