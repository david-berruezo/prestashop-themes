{if isset($items) && $items}
    <section class="testimonials">

        <div class="header_featured_slider"><span>{l s='Testimonials' mod='mpm_testimonials'}</span></div>

        <ul class="testimonials-list">
            {foreach $items as $item}
                <li class="testimonials-list-item">
                    <div class="testimonials-item-img">{if $item['image']}<img alt="{$item['title']|escape:'htmlall':'UTF-8'}" src="{$item['image']|escape:'htmlall':'UTF-8'}">{/if}</div>
                    <div class="testimonials-item-content">
                        <div class="testimonials-item-title"><i class="material-icons">done_all</i>{$item['title']|escape:'htmlall':'UTF-8'}</div>
                        <div class="testimonials-item-description">{$item['description']|escape:'htmlall':'UTF-8' nofilter}</div>
                    </div>
                </li>
            {/foreach}
        </ul>
    </section>
{/if}