{*
* 2017-2018 Zemez
*
* JX Featured Products
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
* @author     Zemez (Alexander Grosul)
* @copyright  2017-2018 Zemez
* @license    http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

<section class="jxfeatured-posts">
  <h1 class="h5 mb-3 text-center">
    {l s='Featured Posts' mod='jxfeaturedposts'}
  </h1>
  {if $featured_posts}
    {include file="module:jxblog/views/templates/front/_partials/post-miniature.tpl" posts=$featured_posts}
  {else}
    <p class="alert alert-warning">{l s='There are no posts to show.' mod='jxfeaturedposts'}</p>
  {/if}
</section>