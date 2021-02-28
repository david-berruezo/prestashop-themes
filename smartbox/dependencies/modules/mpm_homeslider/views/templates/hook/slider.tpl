{if count($slides) > 0 && $settings['active']}
    <div class="carousel-container carousel-homeslider" style="max-height: {$settings['height']|escape:'htmlall':'UTF-8'}px">
        <div id="carousel" >
            {foreach $slides as $slide}
                <div class="carousel-feature">
                    <a {if isset($slide['url']) && $slide['url']} href="{$slide['url']|escape:'htmlall':'UTF-8'}" {/if} {if isset($slide['title']) && $slide['title']} title="{$slide['title']|escape:'htmlall':'UTF-8'}" {/if}>
                        <img class="carousel-image" {if isset($slide['caption']) && $slide['caption']} alt="{$slide['caption']|escape:'htmlall':'UTF-8'}" {/if} src="{$img_dir|escape:'htmlall':'UTF-8'}{$slide['image']|escape:'htmlall':'UTF-8'}">
                    
					    {if isset($slide['description']) && $slide['description']}
                            <div  class="carousel-caption" data-position-desc="{$slide['position_desc']|escape:'htmlall':'UTF-8'}" style="
                                    width: {$slide['width_desc']|escape:'htmlall':'UTF-8'}px;
                                    height: {$slide['height_desc']|escape:'htmlall':'UTF-8'}px;
                            {if $slide['position_desc'] == 'top_left'}
                                    top:10px;
                                    left:10px;
                                    right: inherit;
                                    bottom: inherit;
                            {/if}
                            {if $slide['position_desc'] == 'top_right'}
                                    top:10px;
                                    right:10px;
                                    left: inherit;
                                    bottom: inherit;
                            {/if}
                            {if $slide['position_desc'] == 'bottom_right'}
                                    bottom:10px;
                                    right:10px;
                                    left: inherit;
                                    top: inherit;
                            {/if}
                            {if $slide['position_desc'] == 'bottom_left'}
                                    bottom:10px;
                                    left:10px;
                                    right: inherit;
                                    top: inherit;
                            {/if}
                            {if $slide['position_desc'] == 'center'}

                                    top:calc(50% - {($slide['height_desc']/2)|escape:'htmlall':'UTF-8'}px);
                                    left:calc(50% - {($slide['width_desc']/2)|escape:'htmlall':'UTF-8'}px);
                                    margin: 0 auto;

                            {/if}">

                                {if $slide['opacity_desc']}
                                    <span class="carousel-caption-opacity" style=" opacity: {$slide['opacity_desc']|escape:'htmlall':'UTF-8'};    "></span>
                                {/if}

                                <div class="carousel-caption-cont">
                                    {$slide['description']|escape:'htmlall':'UTF-8' nofilter}
                                </div>
                            </div>
                        {/if}
					
					</a>

                </div>
            {/foreach}
        </div>
    </div>
    <div style="clear: both"></div>
{/if}

