<!-- accounts tpl -->

{if $account_type}
    <!-- account details -->
    {if $account}
        {if isset($account.Agents_count)}
            <ul class="tabs tabs-hash">
                <li class="active" id="tab_listings">
                    <a href="#listings" data-target="listings">{$lang.listings}</a>
                </li>
                <li id="tab_agents">
                    <a href="#agents" data-target="agents">{$lang.agents}</a>
                </li>
            </ul>
        {/if}

        {if isset($account.Agents_count)}<div id="area_listings" class="tab_area">{/if}

        <!-- account listings -->
        {if !empty($listings)}
            {include file='blocks'|cat:$smarty.const.RL_DS|cat:'grid_navbar.tpl'}
            {include file='blocks'|cat:$smarty.const.RL_DS|cat:'grid.tpl'}

            {assign var='pageOnSubdomain' value=false}
            {if $config.account_wildcard && $account_type.Own_location}
                {assign var='pageOnSubdomain' value=true}
            {/if}

            {assign var='custom_url' value=$account.Own_address}
            {if !$account.Own_location}
                {assign var='custom_url' value=$pageInfo.Path|cat:'/'|cat:$account.Own_address}
            {/if}

            <!-- paging block -->
            {if $selected_search_type}
                {if $config.mod_rewrite}
                    {paging calc=$pInfo.calc
                            total=$listings|@count
                            current=$pInfo.current
                            perPage=$config.listings_per_page
                            custom=$custom_url
                            customSubdomain=$pageOnSubdomain
                            url=$search_results_url
                            method=$listing_type.Submit_method
                            container='#listings'}
                {else}
                    {paging calc=$pInfo.calc
                            total=$listings|@count
                            current=$pInfo.current
                            perPage=$config.listings_per_page
                            var='id'
                            url=$account.ID|cat:'&'|cat:$search_results_url
                            full=true
                            container='#listings'}
                {/if}
            {else}
                {if $config.mod_rewrite}
                    {paging calc=$pInfo.calc
                            total=$listings|@count
                            current=$pInfo.current
                            perPage=$config.listings_per_page
                            custom=$custom_url
                            customSubdomain=$pageOnSubdomain
                            container='#listings'}
                {else}
                    {paging calc=$pInfo.calc
                            total=$listings|@count
                            current=$pInfo.current
                            perPage=$config.listings_per_page
                            var='id'
                            url=$account.ID
                            full=true
                            container='#listings'}
                {/if}
            {/if}
            <!-- paging block end -->
        {else}
            {include file=$componentDir|cat:'grid-no-listing/_grid-no-listing.tpl' phraseKey='no_dealer_listings'}
        {/if}
        <!-- account listings end -->

        {if isset($account.Agents_count)}
            </div>

            <div id="area_agents" class="tab_area hide">
                {if $account.Agents_count > 0}
                    <section id="accounts" class="grid row"><div class="col">{$lang.loading}</div></section>
                    <section id="pagination"></section>
                {else}
                    <div class="text-notice">{$lang.agency_not_have_agents}</div>
                {/if}
            </div>

            <script class="fl-js-dynamic">{literal}
                $(function () {
                    let agentsTabOpened = false, agentsCount = {/literal}{$account.Agents_count}{literal};

                    $('#tab_agents').click(function () {
                        if (agentsTabOpened === true) {
                            return;
                        }

                        if (agentsCount) {
                            flGetAgents(1);
                        }

                        agentsTabOpened = true;
                    });

                    if (location.hash && location.hash === '#agents_tab') {
                        if (agentsCount) {
                            flGetAgents(1);
                        }

                        agentsTabOpened = true;
                    }

                    $('a.agencies-agents').click(function () {
                        $('#tab_agents a').trigger('click');
                    })
                });

                let flGetAgents = function (page) {
                    flUtil.ajax(
                        {mode: 'getAgents', agencyID: '{/literal}{$account.ID}{literal}', page: page},
                        function(response) {
                            if (response && response.status === 'OK' && response.agentsHtml) {
                                $('#area_agents #accounts').empty().append(response.agentsHtml);

                                if (response.paginationHTML) {
                                    flUtil.loadScript(
                                        rlConfig.tpl_base + 'components/pagination/_pagination.js',
                                        function () {
                                            let $pagination = $('#area_agents #pagination');
                                            $pagination.empty().append(response.paginationHTML);
                                            flPaginationHandler($pagination);
                                        }
                                    );
                                }
                            } else {
                                printMessage('error', lang.system_error);
                            }
                        }
                    )
                }
            {/literal}</script>
        {/if}
    {else}
        {if $alphabet_dealers}
            {assign var='dealers' value=$alphabet_dealers}
        {/if}

        {if $config.map_module}
        <script>var accounts_map_data = new Array();</script>
        {/if}

        <!-- dealers list -->
        {if $dealers}
            {include file='blocks'|cat:$smarty.const.RL_DS|cat:'grid_navbar_account.tpl'}

            <script>var accounts_map = new Array();</script>
            <div class="ml-3 mr-3 ml-md-0 mr-md-0">
                <section id="accounts" class="grid row gx-2 gy-3 g-md-4">
                    {foreach from=$dealers item='dealer' key='key' name='dealersF'}
                        {include file=$componentDir|cat:'account-card/account-card.tpl'}

                        {if $dealer.Loc_latitude && $dealer.Loc_longitude && $config.map_module}
                        <script class="fl-js-dynamic">
                        accounts_map_data.push({$smarty.ldelim}
                            latLng: [{$dealer.Loc_latitude}, {$dealer.Loc_longitude}],
                            preview: {$smarty.ldelim}
                                component: 'account',
                                id: {$dealer.ID}
                            {$smarty.rdelim}
                        {$smarty.rdelim});
                        </script>
                    {/if}
                    {/foreach}
                </section>
            </div>

            {if $config.map_module}
                <section id="accounts_map" class="hide"></section>

                {mapsAPI assign='mapAPI'}

                <script>
                rlConfig['map_api_css'] = {$mapAPI.css|@json_encode};
                rlConfig['map_api_js'] = {$mapAPI.js|@json_encode};
                </script>
            {/if}

            {if $alphabet_dealers}
                {assign var='pagination_add_url' value=''}
                {if $alphabet_mode}
                    {assign var='pagination_add_url' value=$char}
                {/if}

                {paging calc=$pInfo.calc_alphabet total=$dealers|@count current=$pInfo.current per_page=$config.dealers_per_page url=$pagination_add_url var='character'}
            {else}
                {paging calc=$pInfo.calc total=$dealers|@count current=$pInfo.current per_page=$config.dealers_per_page url=$search_results_url}
            {/if}
        {else}
            <div class="text-notice">{$lang.no_dealers}</div>

            {if $mobile_filter_icon}
                <div class="d-none">
                    {include file=$componentDir|cat:'mobile-filter-icon/mobile-filter-icon.tpl'}
                </div>

                <div class="mt-3 d-lg-none content-padding">
                    <input type="button" class="filter-icon w-100 w-md-auto" value="{$lang.modify_search_criterion}" />
                </div>
            {/if}
        {/if}
        <!-- dealers list end -->
    {/if}
{/if}

<!-- accounts tpl end -->
