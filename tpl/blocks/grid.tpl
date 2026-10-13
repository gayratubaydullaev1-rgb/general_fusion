<!-- listing grid -->

{if !$grid_mode}
    {assign var='grid_mode' value=$smarty.cookies.grid_mode}
{/if}

{if !$grid_mode}
    {assign var='grid_mode' value=$tpl_settings.default_listing_grid_mode}
{/if}

{if $listing_type && !$listing_type.Photo && !$tpl_settings.listing_grid_mode_only}
    {assign var='grid_mode' value='list'}
{/if}

{if $grid_mode == 'map' && !$config.map_module && !$tpl_settings.listing_grid_mode_only}
    {assign var='grid_mode' value=$tpl_settings.default_listing_grid_mode}
{/if}

{if $periods}
    {assign var='cur_date' value=$smarty.now|date_format:'%Y-%m-%d'}
    {assign var='grid_mode' value=$tpl_settings.default_listing_grid_mode}
    {assign var='replace_patter' value=`$smarty.ldelim`day`$smarty.rdelim`}
{/if}

{if $config.map_module}
<script>var listings_map_data = new Array();</script>
{/if}

<div class="ml-3 mr-3 ml-md-0 mr-md-0">
    <section id="listings" class="{$grid_mode} {if $listing_type && !$listing_type.Photo}no-image{/if} {if !($periods && $tpl_settings.listing_grid_mode_only)}row{else}no-gutters{/if} gx-2 gy-3 g-md-4">
        {if $periods && $tpl_settings.listing_grid_mode_only && $listings.0.Post_date == $cur_date}
            <span class="group row gx-2 gy-3 g-md-4">
            {assign var='close_initial_span' value=true}
        {/if}

        {foreach from=$listings item='listing' key='key' name='listingsF'}
            {if $periods && $listing.Post_date != $cur_date}
                {if $listing.Date_diff == 1}
                    {assign var='divider_name' value=$lang.today}
                {elseif $listing.Date_diff == 2}
                    {assign var='divider_name' value=$lang.yesterday}
                {elseif $listing.Date_diff > 2 && $listing.Date_diff < 8}
                    {assign var='divider_name' value=$lang.days_ago_pattern|replace:$replace_patter:$listing.Date_diff-1}
                {else}
                    {assign var='divider_name' value=$listing.Post_date|date_format:$smarty.const.RL_DATE_FORMAT}
                {/if}

                {if $close_initial_span}
                </span>
                {/if}

                {include file='blocks'|cat:$smarty.const.RL_DS|cat:'divider.tpl' name=$divider_name}
                {assign var='cur_date' value=$listing.Post_date}

                {if $tpl_settings.listing_grid_mode_only}
                <span class="group row gx-2 gy-3 g-md-4">
                {assign var='close_initial_span' value=true}
                {/if}
            {/if}
            {include file='blocks'|cat:$smarty.const.RL_DS|cat:'listing.tpl' hl=$hl grid_photo=$grid_photo}

            {if $config.banner_in_grid_position_option
                && $smarty.foreach.listingsF.iteration % $config.banner_in_grid_position == 0
                && !$smarty.foreach.listingsF.last
            }
                <div class="banner-in-grid col-sm-12">
                    {if $blocks.integrated_banner}
                        {showIntegratedBanner blocks=$blocks pageinfo=$pInfo listings=$listings|@count}
                    {else}
                        <div class="banner-space mx-auto d-flex h-100 w-100 justify-content-center align-items-center">{$lang.banner_in_grid_phrase}</div>
                    {/if}
                </div>
            {/if}

            {if $listing.Loc_latitude && $listing.Loc_longitude && $config.map_module}
                <script class="fl-js-dynamic">
                listings_map_data.push({$smarty.ldelim}
                    latLng: [{$listing.Loc_latitude}, {$listing.Loc_longitude}],
                    label: '{$listing.fields[$config.price_tag_field].value}',
                    preview: {$smarty.ldelim}
                        id: {$listing.ID}
                    {$smarty.rdelim}
                {$smarty.rdelim});
                </script>
            {/if}
        {/foreach}

        {if $periods && $tpl_settings.listing_grid_mode_only}
        </span>
        {/if}
    </section>
</div>

{if $config.map_module}
    <section id="listings_map" class="hide"></section>

    {mapsAPI assign='mapAPI'}

    <script>
    rlConfig['map_api_css'] = {$mapAPI.css|@json_encode};
    rlConfig['map_api_js'] = {$mapAPI.js|@json_encode};
    </script>
{/if}

<!-- listing grid end -->
