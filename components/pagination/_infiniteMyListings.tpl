<!-- my listings grid -->

{foreach from=$listings item='listing' key='key'}
    {if $listing.Subscription_ID}
        {assign var='hasSubscriptions' value=true}
    {/if}
    {include file='blocks'|cat:$smarty.const.RL_DS|cat:'my_listing.tpl'}
{/foreach}

<!-- my listings grid end -->
