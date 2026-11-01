<!-- Call owner mobile floating buttons -->

{if !$is_owner && $pageInfo.Controller == 'listing_details' && ($config.messages_module || $config.show_call_owner_button)}
    {addCSS file=$rlTplBase|cat:'components/call-owner/call-owner-buttons.css'}
    <div class="contact-owner-navbar d-lg-none hlight w-100">
        <div class="point1 container mx-auto">
            <div class="contact-owner-navbar__row d-flex flex-nowrap content-padding">
                {if $config.messages_module}
                    <button type="button" class="contact-owner contact-owner-navbar__btn contact-owner-navbar__btn_write" accesskey="{phrase key='contact_owner'}">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M4 5h16v11H9l-5 4z"/></svg>
                        <span>{phrase key='contact_owner'}</span>
                    </button>
                {/if}

                {if $config.show_call_owner_button}
                    <button type="button" class="call-owner contact-owner-navbar__btn contact-owner-navbar__btn_call" data-listing-id="{$listing_data.ID}">
                        <svg viewBox="0 0 24 24" aria-hidden="true"><path d="M5 4h4l2 5-2.5 1.5a11 11 0 0 0 5 5L15 13l5 2v4a2 2 0 0 1-2 2A16 16 0 0 1 3 6a2 2 0 0 1 2-2z"/></svg>
                        <span>{phrase key='call_owner'}</span>
                    </button>
                {/if}
            </div>
        </div>
    </div>

    <script>
    {literal}

    (function(){
        $('body').append(
            $('<div>')
                .addClass('contact-owner-navbar-crossbar')
                .css('flex', '0 0 ' + $('.contact-owner-navbar').height() + 'px')
                .height($('.contact-owner-navbar').height())
        );
    })();

    {/literal}
    </script>
{/if}

<!-- Call owner mobile floating buttons end -->
