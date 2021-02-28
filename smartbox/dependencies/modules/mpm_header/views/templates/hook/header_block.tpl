
{block name='header_min'}
    {hook h='displayMinHeader'}
{/block}


{block name='header_banner'}
    <div class="header-banner">
        {hook h='displayBanner'}
    </div>
{/block}

{block name='header_nav'}
    <nav class="header-nav">
        <div class="container">

        <div class="_desktop_header_selector">
            {widget name="ps_languageselector"}
            {widget name="ps_currencyselector"}
            {widget name="ps_contactinfo" hook="displayNav1"}
        </div>

        <div class="_desktop_header">
            {widget name="ps_customersignin" hook="displayNav1"}
        </div>

        </div>
    </nav>
{/block}

{block name='header_top'}
    <div class="header-top">
        <div class="container">
            <div class="row">

                <div class="_desktop_header_block">
                    <div class="_desktop_logo" id="_desktop_logo">
                        <a href="{$urls.base_url|escape:'htmlall':'UTF-8'}">
                            <img class="logo img-responsive" src="{$shop.logo|escape:'htmlall':'UTF-8'}" alt="{$shop.name|escape:'htmlall':'UTF-8'}">
                        </a>
                    </div>

                    <div class="_desktop_right_block">
                        {widget name="ps_shoppingcart"}
                        <div id="search-button">	<i class="material-icons search">&#xE8B6;</i></div>
                        {widget name="ps_searchbar"}
                        <div class="displayTopMenu">
                            {hook h='displayTopMenu'}
                        </div>
                    </div>

                </div>


                <div class="col-md-10 col-sm-12 position-static">
                    <div class="row">
                        {hook h='displayTop'}
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div style="clear: both"></div>
            </div>
            <div id="mobile_top_menu_wrapper" class="row hidden-md-up" style="display:none;">
                <div class="js-top-menu mobile" id="_mobile_top_menu"></div>
                <div class="js-top-menu-bottom">
                    <div id="_mobile_currency_selector"></div>
                    <div id="_mobile_language_selector"></div>
                    <div id="_mobile_contact_link"></div>
                </div>
            </div>
        </div>
    </div>


    {hook h='displayNavFullWidth'}
    {hook h='displaySubcategories'}
{/block}

