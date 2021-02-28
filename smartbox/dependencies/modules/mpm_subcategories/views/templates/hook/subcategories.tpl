

    <div class="block-category-info" style="{if isset($background) && $background}background: {$background|escape:'htmlall':'UTF-8'};{/if}">
        <div class="container">
            {if isset($image) && $image && isset($cat['img']) && $cat['img']}
                <div class="block-category-cover">
                    <img alt="{$cat['name']|escape:'htmlall':'UTF-8'}" src="{$cat['img']|escape:'htmlall':'UTF-8'}">
                </div>
            {/if}

            <div class="block-category-description"  {if isset($image) && $image && $cat['img']} style="height: {$cat['height']|escape:'htmlall':'UTF-8'}px" {/if}>
                {if $cat['name'] && isset($title) && $title}
                    <h1 class="h1">{$cat['name']|escape:'htmlall':'UTF-8'}</h1>
                {/if}

                {if $cat['description'] && isset($description) && $description}
                    <div id="block-category-description">{$cat['description']|escape:'htmlall':'UTF-8' nofilter}</div>
                {/if}
            </div>

            <div style="clear: both"></div>
        </div>
    </div>
