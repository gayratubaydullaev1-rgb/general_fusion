<!-- account card -->

{math assign='aspect_ratio' equation='h*100/w' w=$dealer.Thumb_width h=$dealer.Thumb_height}

<article class="col-md-4 col-6 col-lg-{if $side_bar_exists}4{else}3{/if} col-xxl-3{if !$dealer.Photo} no-picture{/if}">
    <div class="main-container position-relative">
        {if $dealer.Personal_address}<a title="{$dealer.Full_name}" href="{$dealer.Personal_address}">{/if}
            <div class="picture" style="padding-bottom: {$aspect_ratio}%">
                {if $dealer.Photo}
                    <img alt="{$dealer.Full_name}"
                         src="{$smarty.const.RL_FILES_URL}{$dealer.Photo}"
                         {if $dealer.Photo_x2}srcset="{$smarty.const.RL_FILES_URL}{$dealer.Photo_x2} 2x"{/if} />
                {/if}
            </div>
        {if $dealer.Personal_address}</a>{/if}

        <div class="account-card__counters">
            {if $dealer.Listings_count}
                <div class="account-card__counter-item">
                    <span>{$dealer.Listings_count} {$lang.listings}</span>
                </div>
            {/if}

            {if $dealer.Agents_count}
                <div class="account-card__counter-item mt-1">
                    <span>{$lang.agents} {$dealer.Agents_count}</span>
                </div>
            {/if}
        </div>

        <div class="statistics">
            <ul>
                {*<li class="date" title="{$lang.join_date}">
                    {assign var='type_replace' value=`$smarty.ldelim`account_type`$smarty.rdelim`}
                    {assign var='date_replace' value=`$smarty.ldelim`date`$smarty.rdelim`}
                    {assign var='date' value=$dealer.Date|date_format:$smarty.const.RL_DATE_FORMAT}

                    {$lang.account_type_since_data|replace:$type_replace:$dealer.Type_name|replace:$date_replace:$date}
                </li>*}
                {rlHook name='accountAfterStats'}
            </ul>
        </div>
    </div>

    <ul class="info">
        <li class="account-card__name pb-1">
            {if $dealer.Personal_address}<a title="{$lang.visit_owner_page}" href="{$dealer.Personal_address}">{/if}
            {$dealer.Full_name}
            {if $dealer.Personal_address}</a>{/if}
        </li>
        <li class="account-card__fields-cont d-flex flex-wrap">
            {assign var='phone' value=false}
            {assign var='inline_fields' value=false}

            {foreach from=$dealer.fields item='item' key='field'}
                {if $item.Key == 'First_name' || $item.Key == 'Last_name' || $item.Key == 'company_name'}{continue}{/if}

                {if !empty($item.value) && $item.Details_page}
                    {if $item.Key|strpos:'phone' || $item.Type == 'phone'}
                        {assign var='phone' value=$item.value}
                        {assign var='hiddenPhone' value=$item.Hidden}
                    {else}
                        <span class="account-card__field">{$item.value}</span>
                    {/if}
                {/if}
            {/foreach}

            {rlHook name='accountAfterFields'}
        </li>

        {if $phone}
            <li class="tel">
                {if !$hiddenPhone}<a dir="ltr" href="{if $allow_contacts}tel:{$phone}{else}javascript://{/if}">{/if}
                {$phone}
                {if !$hiddenPhone}</a>{/if}
            </li>
        {/if}
    </ul>
</article>

<!-- account card end -->
