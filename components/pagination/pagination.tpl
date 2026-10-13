<!-- pagination tpl -->

{if $pagination.container && $pagination.mode == 'modern' && $pagination_mode == 'scroll'}
    {if $pagination.total >= $pagination.perPage}
        {include file=$componentDir|cat:'pagination/_infiniteScroll.tpl'}
    {/if}
{else}
    <ul class="pagination d-flex justify-content-center justify-content-md-end">
        {if $pagination.current > 1}
            <li class="navigator ls">
                <a title="{$lang.prev_page}" class="button" href="{if $pagination.current == 2}{$pagination.first_url}{else}{$pagination.tpl_url|replace:'[pg]':$pagination.current-1}{/if}">&lsaquo;</a>
            </li>
        {/if}

        {assign var='nextPage' value=false}

        {if $pagination.mode == 'modern' && $pagination_mode == 'less'}
            <li class="pl-3 pr-3 align-content-center">{$lang.page}: {$pagination.current}</li>

            {if $pagination.total == $pagination.perPage}
                {assign var='nextPage' value=true}
            {/if}
        {else}
            <li class="transit">
                <span>{$lang.page} </span>
                <input maxlength="{$pagination.pages|@count_characters}" type="text" size="{$pagination.pages|@count_characters}" value="{$pagination.current}">
                <input type="hidden" name="stats" value="{$pagination.current}|{$pagination.pages}">
                <input type="hidden" name="pattern" value="{$pagination.tpl_url}">
                <input type="hidden" name="first" value="{$pagination.first_url}">
                <span> {$lang.of} {$pagination.pages}</span>
            </li>

            {if $pagination.current < $pagination.pages}
                {assign var='nextPage' value=true}
            {/if}
        {/if}

        {if $nextPage}
            <li class="navigator rs">
                <a title="{$lang.next_page}" class="button" href="{$pagination.tpl_url|replace:'[pg]':$pagination.current+1}">&rsaquo;</a>
            </li>
        {/if}
    </ul>

    {if $pagination.mode != 'modern'
        || ($pagination.mode == 'modern' && $pagination_mode == 'default')
    }
    <script class="fl-js-dynamic">{literal}
        flUtil.loadScript(rlConfig.tpl_base + 'components/pagination/_pagination.js', function() {
            flPaginationHandler($('ul.pagination'));
        });
    {/literal}</script>
    {/if}
{/if}

<!-- pagination tpl end -->
