{include file='head.tpl'}

{addCSS file=$rlTplBase|cat:'components/mobile-header/mobile-header.css'}
{addCSS file=$rlTplBase|cat:'components/desktop-polish/desktop-polish.css'}

{include file='../img/gallery.svg'}

<a class="skip-link" href="#main_container">{$lang.skip_to_content|default:'Skip to content'}</a>

<div class="main-wrapper d-flex flex-column">
    <header class="page-header{if $config.mobile_footer_menu && $pageInfo.Key != 'search_on_map'} has-mobile-bar{/if}{if $pageInfo.Key == 'home' && !$config.main_menu_home_page} main-menu-hidden{/if}{if $pageInfo.Key == 'search_on_map'} fixed-menu{/if}">
        <div class="top-header content-padding mb-2 mb-md-3">
            <div class="point1 mx-auto">
                <div class="d-flex justify-content-between">
                    <nav class="main-menu d-flex flex-wrap priority-z-index">
                        {include file='menus'|cat:$smarty.const.RL_DS|cat:'main_menu.tpl'}
                    </nav>

                    {* Mobile only: the search field is moved here by the script below (see after the smart search include) *}
                    <div class="mobile-search-slot d-md-none" id="mobile-search-slot"></div>

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
                                <img alt="{$config.site_name}" width="200" height="40" src="{$rlTplBase}img/logo.svg?rev={$config.static_files_revision}" />
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

                        <script>
                        {literal}
                        // Mobile (<768px): the smart search (and the profile icon, if there is no bottom bar)
                        // live in the top header; on desktop they stay in their own row
                        (function(){
                            if (!window.matchMedia) {
                                return;
                            }
                            var mq = window.matchMedia('(max-width: 767px)');
                            var hasBar = document.querySelector('header.page-header.has-mobile-bar') !== null;
                            var items = [
                                {el: document.querySelector('.top-navigation .smart-search'), target: document.getElementById('mobile-search-slot')}
                            ];
                            if (!hasBar && !document.querySelector('header.page-header.fixed-menu')) {
                                items.push({el: document.querySelector('.top-navigation .user-navbar'), target: document.querySelector('.user-navbar-right')});
                            }
                            items = items.filter(function(i){ return i.el && i.target; });
                            items.forEach(function(i){
                                i.home = i.el.parentNode;
                                i.next = i.el.nextSibling;
                            });
                            var place = function(){
                                items.forEach(function(i){
                                    if (mq.matches) {
                                        i.target.appendChild(i.el);
                                    } else {
                                        i.home.insertBefore(i.el, i.next && i.next.parentNode === i.home ? i.next : null);
                                    }
                                });
                            };
                            place();
                            if (mq.addEventListener) {
                                mq.addEventListener('change', place);
                            } else if (mq.addListener) {
                                mq.addListener(place);
                            }
                        })();
                        {/literal}
                        </script>

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
