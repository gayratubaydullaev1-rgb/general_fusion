<!-- account search -->

<form class="light-inputs" method="post" action="{pageUrl key=$pageInfo.Key add_url=$search_results_url}">
    {include file='blocks'|cat:$smarty.const.RL_DS|cat:'fields_search_box.tpl'}

    <div class="search-button">
        <input type="hidden" name="search" value="true" />
        <input type="submit" name="search" value="{$lang.search}" />
    </div>
</form>

<!-- account search end -->
