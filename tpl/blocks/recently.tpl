<!-- recently listings area -->
{assign var='partition' value=$listing_types.$lt_key.Page_key}

{if $listings}
    {include file='blocks'|cat:$smarty.const.RL_DS|cat:'grid.tpl' periods=true}

    {if $listing_types|@count > 1}
        {if $config.mod_rewrite}
            {assign var="type_url" value=$pages.$partition}
        {else}
            {assign var="type_url" value='type='|cat:$pages.$partition}
        {/if}
    {/if}

    <!-- paging block -->
    {paging calc=$pInfo.calc
            total=$listings|@count
            current=$pInfo.current
            per_page=$config.listings_per_page
            url=$type_url
            container='#area_'|cat:$listing_type.Key|cat:' #listings'}
    <!-- paging block end -->
{else}
    {include file=$componentDir|cat:'grid-no-listing/_grid-no-listing.tpl'}
{/if}

<!-- recently listings area end -->
