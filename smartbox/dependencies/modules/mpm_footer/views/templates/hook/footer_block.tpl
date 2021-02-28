<div class="displayFooterBefore">
    {hook h='displayFooterBefore'}
</div>
<div class="footer-container">
    <div class="container">

        <div class="row">
            {hook h='displayFooter'}
        </div>
        <div class="row">

        </div>

    </div>

</div>
<div class="displayFooterAfter">
    <div class="container">

        <div class="row">
            {hook h='displayFooterAfter'}
        </div>

    </div>

</div>

<style>
    {if isset($image) && $image}
    .footer-container{
        background: url("{$image|escape:'htmlall':'UTF-8'}");
    }
    {/if}

    {if isset($background_color) && $background_color}
        .footer-container{
            background-color: {$background_color|escape:'htmlall':'UTF-8'};
            color: {$color|escape:'htmlall':'UTF-8'};
        }
    {/if}

    .footer-container h1,
    .footer-container h2,
    .footer-container h3,
    .footer-container h4,
    .footer-container h5,
    .footer-container div,
    .footer-container p,
    .footer-container li a,
    .footer-container a{

    {if isset($color) && $color}
        color: {$color|escape:'htmlall':'UTF-8'} !important;
     {else}
        color: #ffffff !important;
    {/if}
    }
    .footer-container li a:hover{
        {if isset($hover) && $hover}
            color: {$hover|escape:'htmlall':'UTF-8'} !important;
        {else}
            color: #3498db !important;
        {/if}
    }

    .container-footer-info{
        {if isset($color) && $color}
          border-color: {$color|escape:'htmlall':'UTF-8'} !important;
        {/if}
    }


</style>