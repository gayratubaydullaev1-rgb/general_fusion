<!-- Call buttons in sidebar -->

<input type="button" class="w-100 contact-owner" value="{phrase key='contact_owner'}" accesskey="{phrase key='contact_owner'}" />

{if $config.show_call_owner_button && $pageInfo.Controller == 'listing_details'}
    <input class="w-100 mt-3 call-owner" data-listing-id="{$listing_data.ID}" type="button" value="{phrase key='call_owner'}" accesskey="{phrase key='call_owner'}" />
{/if}

<!-- Call buttons in sidebar end -->
