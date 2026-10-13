<!-- grid no listings tpl -->

{if !$noWrapper}<div class="text-notice">{/if}

{if $config.listings_pagination_mode == 'less' && $pInfo.current > 1}
    {phrase key='grid_no_listing_on_page' db_check=true}

    <div class="mt-3">
        <a href="javascript:history.back();" class="button w-100 w-md-auto">{$lang.previous_page}</a>
    </div>
{else}
    {if $customPhrase}
        {$customPhrase}
    {else}
        {if ($listing_type && $listing_type.Admin_only) || !$pages.add_listing}
            {$lang.no_listings_found_deny_posting}
        {else}
            {if $add_listing_link}
                {assign var='link' value='<a href="'|cat:$add_listing_link|cat:'">$1</a>'}
            {else}
                {pageUrl key='add_listing' assign='add_listing_href'}
                {assign var='link' value='<a href="'|cat:$add_listing_href|cat:'">$1</a>'}
            {/if}
            {if $phraseKey}
                {assign var='no_listings_found_phrase' value=$lang.$phraseKey}
            {else}
                {assign var='no_listings_found_phrase' value=$lang.no_listings_found}
            {/if}
            {$no_listings_found_phrase|regex_replace:'/\[(.+)\]/':$link}
        {/if}
    {/if}

    {if $mobile_filter_icon}
        <div class="d-none">
            {include file=$componentDir|cat:'mobile-filter-icon/mobile-filter-icon.tpl'}
        </div>

        <div class="mt-3 d-lg-none">
            <input type="button" class="filter-icon w-100 w-md-auto" value="{$lang.modify_search_criterion}" />
        </div>
    {/if}
{/if}

{if !$noWrapper}</div>{/if}

<!-- grid no listings tpl end -->
