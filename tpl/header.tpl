{include file='head.tpl'}

{include file='../img/gallery.svg'}

<div class="main-wrapper d-flex flex-column">
    <header class="page-header{if $pageInfo.Key == 'home' && !$config.main_menu_home_page} main-menu-hidden{/if}{if $pageInfo.Key == 'search_on_map'} fixed-menu{/if}">
        <div class="top-header content-padding mb-2 mb-md-3">
            <div class="point1 mx-auto">
                <div class="d-flex justify-content-between">
                    <nav class="main-menu d-flex flex-wrap priority-z-index">
                        {include file='menus'|cat:$smarty.const.RL_DS|cat:'main_menu.tpl'}
                    </nav>

                    <div class="user-navbar-right d-flex">
                        {rlHook name='tplHeaderUserNav'}
                        {include file='blocks'|cat:$smarty.const.RL_DS|cat:'lang_selector.tpl'}

                        <span class="circle" id="theme-switcher">
                            <span class="default">
                                <svg viewBox="0 0 16 16">
                                    {if $smarty.cookies.colorTheme}
                                    <use xlink:href="#theme-{if $smarty.cookies.colorTheme == 'dark'}sun{else}moon{/if}-icon"></use>
                                    {else}
                                    <use id="theme-switcher-sun" xlink:href="#theme-sun-icon"></use>
                                    <use id="theme-switcher-moon" xlink:href="#theme-moon-icon"></use>
                                    {/if}
                                </svg>
                            </span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="point1 clearfix">
            <div class="top-navigation content-padding">
                <div class="point1 mx-auto position-relative">
                    <div class="d-flex flex-wrap align-items-center position-relative justify-content-between gap-3 gap-xl-4">
                        <div class="mr-auto col-auto order-1" id="logo">
                            <a href="{$rlBase}" title="{$config.site_name}">
                                <img alt="{$config.site_name}" src="{$rlTplBase}img/logo.svg?rev={$config.static_files_revision}" />
                            </a>
                        </div>
                        {if $pageInfo.Key != 'search_on_map'}
                            <div class="d-flex col-12 col-xl order-last w-100 order-xl-2 flex-column-reverse flex-md-row gap-3">
                                {include file='menus'|cat:$smarty.const.RL_DS|cat:'category_menu.tpl'}
                                {include file='blocks/smart_search.tpl'}
                            </div>
                        {/if}
                        <div class="col-auto d-flex justify-content-end user-navbar pr-0 order-3">
                            {rlHook name='tplHeaderUserArea'}

                            {include file='blocks'|cat:$smarty.const.RL_DS|cat:'user_navbar.tpl'}
                        </div>

                        {foreach name='mMenu' from=$main_menu item='menu_item'}
                            {if $menu_item.Key == 'add_listing'}{assign var='add_listing_button' value=$menu_item}{break}{/if}
                        {/foreach}

                        {if $add_listing_button}
                            {include file='menus/menu_item.tpl' menuItem=$add_listing_button itemClass='button add-property order-5 d-none d-md-flex'}
                        {/if}
                    </div>

                    {if $pageInfo.Key != 'search_on_map'}
                        {include file='menus'|cat:$smarty.const.RL_DS|cat:'category_menu_content.tpl'}
                    {/if}
                </div>
            </div>
        </div>
        {assign var='page_menu' value=','|explode:$pageInfo.Menus}

        {if $pageInfo.Key == 'home'}
        <section class="header-nav d-flex flex-column">
            {include file='blocks'|cat:$smarty.const.RL_DS|cat:'home_content.tpl'}
        </section>
        {/if}
    </header>
