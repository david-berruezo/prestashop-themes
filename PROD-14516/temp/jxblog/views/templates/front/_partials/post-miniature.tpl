{*
* 2017 Zemez
*
* JX Blog
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
*  @author    Zemez (Alexander Grosul)
*  @copyright 2017 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if isset($is_slider) && $is_slider}{else}
<section class="blog-posts row">{/if}
  {foreach from=$posts item='post'}
    {block name='blog_post_miniature'}
      <article class="bp-miniature {if isset($is_slider) && $is_slider}bp-slide{else}col-sm-6 col-lg-4 mb-3{/if}">
        <div class="bp-thumbnail">
          <a href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
            <img class="img-fluid" src="{JXBlogImageManager::getImage('post_thumb', $post.id_jxblog_post, 'post_listing')}" alt="{$post.name}">
          </a>
        </div>
        <div class="bp-info">
          <p class="post-meta"><span class='month'>{$post.date_start|date_format:"%B"}</span> <span class='day'>{$post.date_start|date_format:"%d"}</span> {$post.date_start|date_format:"%Y"}</p>
          <h1 class="h6 bp-name">
            <a href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}">
              {$post.name}
            </a>
          </h1>
          {if $post.short_description}
            <div class="bp-short-description">
              {$post.short_description nofilter}
            </div>
          {/if}
          <a class="link" href="{url entity='module' name='jxblog' controller='post' params = ['id_jxblog_post' => $post.id_jxblog_post, 'rewrite' => $post.link_rewrite]}" title="{l s='Read more' mod='jxblog'}">{l s='Read more' mod='jxblog'} <i></i></a>
        </div>
      </article>
    {/block}
  {/foreach}
  {if isset($is_slider) && $is_slider}{else}</section>{/if}
