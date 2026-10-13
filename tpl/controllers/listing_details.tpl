<!-- listing details -->

{if !$errors}

{if $config.map_module && $location.direct}
    {mapsAPI assign='mapAPI'}

    <script>
    rlConfig['mapAPI'] = [];
    rlConfig['mapAPI']['css'] = JSON.parse('{$mapAPI.css|@json_encode}');
    rlConfig['mapAPI']['js']  = JSON.parse('{$mapAPI.js|@json_encode}');
    </script>
{/if}

<div class="listing-details details {if $config.map_module && $location.direct && $photos}loc-exists{/if}{if !$photos} no-listing-photos{/if}">
    {rlHook name='listingDetailsTopTpl'}

    <div class="top-navigation d-flex justify-content-between">
        {rlHook name='tplListingDetailsNavLeft'}
        {rlHook name='tplListingDetailsNavRight'}
    </div>

    <section class="main-section">
        {if $photos}
            {include file=$componentDir|cat:'listing-details-gallery/_listing-details-gallery.tpl'}
        {/if}
    </section>

    <section class="content-section clearfix">
        <!-- tabs -->
        {if $tabs|@count > 1}
            <ul class="tabs tabs-hash">
                {foreach from=$tabs item='tab' name='tabF'}{strip}
                    <li {if $smarty.foreach.tabF.first}class="active"{/if} id="tab_{$tab.key}">
                        <a href="#{$tab.key}" data-target="{$tab.key}">{$tab.name}</a>
                    </li>
                {/strip}{/foreach}
            </ul>
        {/if}
        <!-- tabs end -->

        <!-- listing details -->
        <div id="area_listing" class="tab_area">
            <div class="d-flex flex-wrap align-items-center justify-content-between">
                <!-- price tag -->
                {if $price_tag.value}
                    <div class="price-tag mb-3" id="df_field_price">
                        {if $price_tag.Options.from}{$lang.price_from}{/if}
                        <span>
                            {if $price_contact_form}
                                <a href="javascript://"
                                    class="contact-owner price-contact-form"
                                    data-listing-id="{$listing_data.ID}"
                                    data-account-id="{$listing_data.Account_ID}"
                                >
                            {/if}
                            {$price_tag.value}
                            {if $price_contact_form}</a>{/if}
                        </span>
                        {if $listing_data.sale_rent == 2 && $listing.common.Fields.time_frame.value}
                            / {$listing.common.Fields.time_frame.value}
                        {/if}
                    </div>
                {/if}
                <!-- price tag end -->

                {if $listing.common.Fields.bedrooms.value || $listing.common.Fields.bathrooms.value || $listing.common.Fields.square_feet.value}
                    <ul class="card-info mb-3">
                        <li class="services">{strip}
                            {if $listing.common.Fields.bedrooms.value}
                                <span title="{$listing.fields.bedrooms.name}" class="badrooms">{$listing.common.Fields.bedrooms.value}</span>
                            {/if}
                            {if $listing.common.Fields.bathrooms.value}
                                <span title="{$listing.fields.bathrooms.name}" class="bathrooms">{$listing.common.Fields.bathrooms.value}</span>
                            {/if}
                            {if $listing.common.Fields.square_feet.value}
                                <span title="{$listing.fields.square_feet.name}" class="square_feet">{$listing.common.Fields.square_feet.value}</span>
                            {/if}
                        {/strip}</li>
                    </ul>
                {/if}

                <div class="mb-3">
                    {rlHook name='tplListingDetailsRating'}
                </div>
            </div>

            {rlHook name='listingDetailsPreFields'}

            {include file=$controllerDir|cat:'listing_details/details.tpl'}
            {include file=$controllerDir|cat:'listing_details/statistics.tpl'}
        </div>
        <!-- listing details end -->

        {if $config.tell_a_friend_tab}
            <!-- tell a friend tab -->
            <div id="area_tell_friend" class="tab_area hide">
                <div class="content-padding">
                    <div class="submit-cell">
                        <div class="name">{$lang.friend_name} <span class="red">*</span></div>
                        <div class="field"><input class="wauto" type="text" id="friend_name" name="friend_name" maxlength="50" size="30" value="{$smarty.post.friend_name}" /></div>
                    </div>

                    <div class="submit-cell">
                        <div class="name">{$lang.friend_email} <span class="red">*</span></div>
                        <div class="field"><input class="wauto" type="text" id="friend_email" name="friend_email" maxlength="50" size="30" value="{$smarty.post.friend_email}" /></div>
                    </div>

                    <div class="submit-cell">
                        <div class="name">{$lang.your_name}</div>
                        <div class="field"><input class="wauto" type="text" id="your_name" name="your_name" maxlength="100" size="30" value="{$account_info.Full_name}" /></div>
                    </div>

                    <div class="submit-cell">
                        <div class="name">{$lang.your_email}</div>
                        <div class="field"><input class="wauto" type="text" id="your_email" name="your_email" maxlength="30" size="30" value="{$account_info.Mail}" /></div>
                    </div>

                    <div class="submit-cell">
                        <div class="name">{$lang.message}</div>
                        <div class="field"><textarea id="message" name="message" rows="6" cols="50">{$smarty.post.message}</textarea></div>
                    </div>

                    {if $config.security_img_tell_friend}
                    <div class="submit-cell">
                        <div class="name">{$lang.security_code} <span class="red">*</span></div>
                        <div class="field">
                            {include file='captcha.tpl' no_caption=true}
                        </div>
                    </div>
                    {/if}

                    <div class="submit-cell buttons">
                        <div class="name"></div>
                        <div class="field"><input onclick="xajax_tellFriend($('#friend_name').val(), $('#friend_email').val(), $('#your_name').val(), $('#your_email').val(), $('#message').val(), $('#security_code').val(), '{$print.id}');$(this).val('{$lang.loading}');" type="button" name="finish" value="{$lang.send}" /></div>
                    </div>
                </div>
            </div>
            <!-- tell a friend tab end -->
        {/if}

        <!-- tabs content -->
        {rlHook name='listingDetailsBottomTpl'}
        <!-- tabs content end -->
    </section>

    <script class="fl-js-dynamic">
    {if isset($smarty.get.highlight)}
        flynaxTpl.highlightResults("{$smarty.session.keyword_search_data.keyword_search}", true);
    {/if}

    var ld_inactive = {if $pageInfo.Listing_details_inactive}'{$lang.ld_inactive_notice}'{else}false{/if};

    {literal}
        if ($('#df_field_vin .value').length > 0) {
            var html = '<a style="font-size: 14px;" href="javascript:void(0);">{/literal}{if $lang.check_vin}{$lang.check_vin}{else}Check Vin{/if}{literal}</a>';
            var vin = trim( $('#df_field_vin .value').text() );
            var frame = '<iframe scrolling="auto" height="600" frameborder="0" width="100%" src="https://www.carfax.com/cfm/check_order.cfm?vin='+vin+'" style="border: 0pt none;overflow-x: hidden; overflow-y: auto;background: white;"></iframe>';
            var source = '';
        }
    {/literal}
    </script>

    {rlHook name='listingDetailsBottomJs'}

    <script class="fl-js-dynamic">
    {literal}
    $(document).ready(function(){
        if (ld_inactive) {
            printMessage('warning', ld_inactive, false, true);
        }

        $('#df_field_vin .value').append(html);

        $('#df_field_vin .value a').flModal({
            content: frame,
            source: source,
            width: 900,
            height: 640
        });

        flynaxTpl.setupTextarea();
    });

    {/literal}
    </script>

</div>
{else}
    <!-- TODO HERE -->
{/if}

<!-- listing details end -->

