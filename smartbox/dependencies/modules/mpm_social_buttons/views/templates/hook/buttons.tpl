
<div class="col-md-3 links footer_soc_button">
    <div class="row">


        <h3 class="h3 hidden-sm-down">Social</h3>

        <div class="title clearfix hidden-md-up" data-target="#footer_sub_menu_social" data-toggle="collapse">
            <span class="h3">Social</span>
            <span class="pull-xs-right">
              <span class="navbar-toggler collapse-icons">
                <i class="material-icons add">&#xE313;</i>
                <i class="material-icons remove">&#xE316;</i>
              </span>
            </span>
        </div>
        <ul id="footer_sub_menu_social" class="collapse">
            {if isset($facebook) && $facebook}
                <li class="facebook icon-gray">
                    <a href="{$facebook|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($twitter) && $twitter}
                <li class="twitter icon-gray">
                    <a href="{$twitter|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($rss) && $rss}
                <li class="rss icon-gray">
                    <a href="{$rss|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($youtube) && $youtube}
                <li class="youtube icon-gray">
                    <a href="{$youtube|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($google) && $google}
                <li class="googleplus icon-gray">
                    <a href="{$google|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($pinterest) && $pinterest}
                <li class="pinterest icon-gray">
                    <a href="{$pinterest|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($vimeo) && $vimeo}
                <li class="vimeo icon-gray">
                    <a href="{$vimeo|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
            {if isset($instagram) && $instagram}
                <li class="instagram icon-gray">
                    <a href="{$instagram|escape:'htmlall':'UTF-8'}"></a>
                </li>
            {/if}
        </ul>


    </div>
</div>
