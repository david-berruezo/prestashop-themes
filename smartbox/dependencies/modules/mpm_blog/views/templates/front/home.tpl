
{if isset($articles) && $articles}
    <section  class="home_page_articles">

        <div class="container">
            <div >
                <h3 class="h3 home_page_articles_title"><span>{l s='Latest articles'  mod='mpm_blog'}</span></h3>
                <ul id="home_page_menu_blog">
                    {foreach from=$articles key=key item=value}
                        {if $value['is_image']}
                            <li class="item_articles item_articles_{$key|escape:'htmlall':'UTF-8'}" style="width: {((100)/(count($articles)))|escape:'htmlall':'UTF-8'}%">

                                <div class="item_articles_content">
                                    <a class="link-blog-img" href="{$blogUrl|escape:'htmlall':'UTF-8'}{$value['link_rewrite_category']|escape:'htmlall':'UTF-8'}/{$value['link_rewrite']|escape:'htmlall':'UTF-8'}.html" >
                                        <img alt=" {$value['name']|truncate:40|escape:'htmlall':'UTF-8'}" class="grid_image_home" src="{$value['is_image']|escape:'htmlall':'UTF-8'}{$value['id_blog_post']|escape:'htmlall':'UTF-8'}-image_home.jpg" />
                                    </a>

                                    <div class="item_articles_header">

                                        <div class="item_articles_background">
                                            <div class="item_articles_info">
                                                <span class="date_add">{date_format(date_create($value['date_add']) ,"d M Y")|escape:'htmlall':'UTF-8'}</span>
                                            </div>
                                            <a class="link-blog-home" href="{$blogUrl|escape:'htmlall':'UTF-8'}{$value['link_rewrite_category']|escape:'htmlall':'UTF-8'}/{$value['link_rewrite']|escape:'htmlall':'UTF-8'}.html" >
                                                {$value['name']|truncate:90|escape:'htmlall':'UTF-8'}
                                            </a>
                                            <span class="home_page_description">
                                                {strip_tags($value['description_short'])|truncate:200:'...'|escape:'htmlall':'UTF-8' nofilter}
                                            </span>
                                            <div class="read-blog-button">
                                                <a class="read-blog-home" href="{$blogUrl|escape:'htmlall':'UTF-8'}{$value['link_rewrite_category']|escape:'htmlall':'UTF-8'}/{$value['link_rewrite']|escape:'htmlall':'UTF-8'}.html" >
                                                    {l s='Read more'  mod='mpm_blog'}
                                                </a>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                            </li>
                        {/if}
                    {/foreach}
                </ul>
            </div>
        </div>

    </section >
{/if}