<!-- main menu block -->

<div class="menu d-none d-md-flex h-100 flex-grow-1 flex-shrink-1 flex-basis-0 shrink-fix">
    <span class="mobile-menu-header d-none align-items-center order-1">
        <span class="mobile-menu-header-title">{$lang.menu}</span>
        <svg viewBox="0 0 12 12" class="mobile-close-icon" role="button" tabindex="0" aria-label="{$lang.close|default:'Close'}">
            <use xlink:href="#close-icon"></use>
        </svg>
    </span>

    <div class="menu-content pt-3 pb-3 pt-md-0 pb-md-0 order-3 order-md-2 shrink-fix flex-wrap">
    {foreach name='mMenu' from=$main_menu item='menu_item'}
        {if $menu_item.Key == 'add_listing'}{assign var='add_listing_button' value=$menu_item}{continue}{/if}
        {include file='menus/menu_item.tpl' menuItem=$menu_item}
    {/foreach}
    </div>

    {if $add_listing_button}
        {include file='menus/menu_item.tpl' menuItem=$add_listing_button itemClass='d-md-none button ml-md-4 add-property order-2 order-md-3 flex-shrink-0'}
    {/if}
</div>

<span class="menu-button pl-2 pr-2 d-flex d-md-none align-items-center" title="{$lang.menu}" role="button" tabindex="0" aria-label="{$lang.menu|escape}">
    <svg viewBox="0 0 20 14">
        <use xlink:href="#mobile-menu"></use>
    </svg>
</span>

<!-- main menu block end -->
