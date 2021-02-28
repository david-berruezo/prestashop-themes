{**
 * 2007-2018 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2018 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<!doctype html>
<html lang="{$language.iso_code}">

  <head>
    {block name='head'}
      {include file='_partials/head.tpl'}
    {/block}
  </head>

  <body id="{$page.page_name}" class="{block name='body_classes_override'}{$page.body_classes|classnames} {/block}">

    {block name='hook_after_body_opening_tag'}
      {hook h='displayAfterBodyOpeningTag'}
    {/block}

    <main data-canvas="container">
      {block name='product_activation'}
        {include file='catalog/_partials/product-activation.tpl'}
      {/block}

      <header id="header">
        {block name='header'}
          {include file='_partials/header.tpl'}
        {/block}
      </header>

      {block name='notifications'}
        {include file='_partials/notifications.tpl'}
      {/block}

      {assign var='displayMegaTopColumn' value={hook h='jxMegaLayoutTopColumn'}}
      {if $displayMegaTopColumn && $page.page_name == 'index'}
        <section id="top-column">
          {hook h='jxMegaLayoutTopColumn'}
        </section>
      {/if}

      <section id="wrapper">
        {if $page.page_name == 'index'}
          {assign var='displayMegaHome' value={hook h='jxMegaLayoutHome'}}
          {if $displayMegaHome}
            {$displayMegaHome nofilter}
          {/if}
        {else}
          {hook h="displayWrapperTop"}
          <div {block name='wrapper-container-class'}class="container"{/block}>
            {block name='breadcrumb-block'}
              <div class="row">
                <div class="col-12 col-lg-6 offset-lg-3">
                  {block name='breadcrumb'}
                    {include file='_partials/breadcrumb.tpl'}
                  {/block}
                </div>
              </div>
            {/block}
            <div {block name='content-container-class'}{/block}>
              <div class="row">
                {block name="content_wrapper"}
                  <div class="content-wrapper layout-both-columns col-12 col-md-6">
                    {hook h="displayContentWrapperTop"}
                    {block name="content"}
                      <p>Hello world! This is HTML5 Boilerplate.</p>
                    {/block}
                    {hook h="displayContentWrapperBottom"}
                  </div>
                {/block}

                {block name="left_column"}
                  {assign var=original_hook_name value="displayLeftColumn" scope="global"}
                  <div class="left-column col-12 col-md-3">
                    {if $page.page_name == 'product'}
                      {hook h='displayLeftColumnProduct'}
                    {else}
                      {hook h="displayLeftColumn"}
                    {/if}
                  </div>
                {/block}

                {block name="right_column"}
                  {assign var=original_hook_name value="displayRightColumn" scope="global"}
                  <div class="right-column col-12 col-md-3">
                    {if $page.page_name == 'product'}
                      {hook h='displayRightColumnProduct'}
                    {else}
                      {hook h="displayRightColumn"}
                    {/if}
                  </div>
                {/block}
              </div>
            </div>
          </div>
          {hook h="displayWrapperBottom"}
        {/if}
      </section>

      <footer id="footer">
        {assign var='displayMegaFooter' value={hook h='jxMegaLayoutFooter'}}
        {if $displayMegaFooter}
          {$displayMegaFooter nofilter}
        {else}
          <div class="container">
            {block name="footer"}
              {include file="_partials/footer.tpl"}
            {/block}
          </div>
        {/if}
      </footer>

    </main>

    {block name='javascript_bottom'}
      {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
    {/block}

    {block name='hook_before_body_closing_tag'}
      {hook h='displayBeforeBodyClosingTag'}
    {/block}
  </body>

</html>
