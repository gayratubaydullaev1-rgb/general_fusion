<!-- my favorites -->

{if !empty($listings)}
	{include file='blocks'|cat:$smarty.const.RL_DS|cat:'grid_navbar.tpl'}
	
	{rlHook name='favouriteBeforeListings'}
	
	{include file='blocks'|cat:$smarty.const.RL_DS|cat:'grid.tpl'}
	
	{paging calc=$pInfo.calc
            total=$listings|@count
            current=$pInfo.current
            per_page=$config.listings_per_page
            controller=$pages.my_favorites
            container='#listings'}
{else}
    {include file=$componentDir|cat:'grid-no-listing/_grid-no-listing.tpl' customPhrase=$lang.no_favorite}
{/if}

<!-- my favorites end -->
