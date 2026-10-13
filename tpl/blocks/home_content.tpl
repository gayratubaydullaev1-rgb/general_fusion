<!-- home page content tpl -->

{if $has_category_menu}
    {include file='blocks'|cat:$smarty.const.RL_DS|cat:'categories_carousel.tpl'}
{/if}

{if $home_slides}
    <div class="point1 m-auto mt-3 mt-md-5">
        {include file='blocks'|cat:$smarty.const.RL_DS|cat:'content_slider.tpl'}
    </div>
{/if}

{include file='blocks'|cat:$smarty.const.RL_DS|cat:'horizontal_search.tpl'}

<!-- home page content tpl end -->
