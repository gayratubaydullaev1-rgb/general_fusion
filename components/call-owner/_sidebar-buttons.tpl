<!-- Call buttons in sidebar -->

{addCSS file=$rlTplBase|cat:'components/call-owner/call-owner-buttons.css'}

<div class="contact-owner-sidebar d-flex flex-nowrap">
    <button type="button" class="contact-owner contact-owner-navbar__btn contact-owner-navbar__btn_write" accesskey="{phrase key='contact_owner'}">
        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 5h16v11H9l-5 4z"/></svg>
        <span>{phrase key='contact_owner'}</span>
    </button>

    {if $config.show_call_owner_button && $pageInfo.Controller == 'listing_details'}
        <button type="button" class="call-owner contact-owner-navbar__btn contact-owner-navbar__btn_call" data-listing-id="{$listing_data.ID}" accesskey="{phrase key='call_owner'}">
            <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 4h4l2 5-2.5 1.5a11 11 0 0 0 5 5L15 13l5 2v4a2 2 0 0 1-2 2A16 16 0 0 1 3 6a2 2 0 0 1 2-2z"/></svg>
            <span>{phrase key='call_owner'}</span>
        </button>
    {/if}
</div>

<!-- Call buttons in sidebar end -->
