{extends file=$layout}
{block name='breadcrumb'}
    <nav class="container hidden-sm-down">
        <ol class="breadcrumb" itemscope itemtype="http://schema.org/BreadcrumbList">
            <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                <a href="{$link->getModuleLink('jxlookbook', 'jxlookbook')|escape:'html':'UTF-8'}">
                    <span itemprop="name">{l s='All LookBooks' mod='jxlookbook'}</span>
                </a>
            </li>
            <li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
          <span>
            <span itemprop="name">{$name}</span>
          </span>
            </li>
        </ol>
    </nav>
{/block}

{block name='wrapper-container-class'}class="container-fluid"{/block}

{block name="content"}
    {$content nofilter}
{/block}