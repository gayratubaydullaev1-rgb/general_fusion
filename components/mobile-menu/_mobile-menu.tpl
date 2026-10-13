<!-- mobile menu -->

{include file=$componentDir|cat:'mobile-menu/icons.svg'}
{addCSS file=$rlTplBase|cat:'components/mobile-menu/mobile-menu.css'}

<script>
lang['account'] = "{$lang.account}";
{literal}

$(function(){
    // Menu on scroll handling
    var scrolling = false;
    var lastScrollTop = 0;
    var visibilityClass = 'mb-menu_visible';
    var $mbMenu = $('.mb-menu');

    if (!$mbMenu.hasClass('mb-menu_no-hide')) {
        var menuHeight = $mbMenu.height();

        $(window).scroll(function(event){
            scrolling = true;
        });

        setInterval(function() {
            if (scrolling) {
                onScroll();
                scrolling = false;
            }
        }, 250);

        function onScroll() {
            var st = $(this).scrollTop();
            var wh = $(window).height();
            var dh = $(document).height();

            if (st > 0 && st > lastScrollTop && (st + wh) < (dh - (wh / 2))) {
                $mbMenu.removeClass(visibilityClass)
            } else {
                $mbMenu.addClass(visibilityClass)
            }
            
            lastScrollTop = st;
        }
    }

    // Account icon handler
    var $activeItem = null;
    var itemActiveClass = 'mb-menu__item-active';
    var $mbMenu_account = $('.mb-menu__item-account');

    flUtil.loadStyle(rlConfig.tpl_base + 'components/popup/popup.css');
    flUtil.loadScript(rlConfig.tpl_base + 'components/popup/_popup.js', function() {
        $mbMenu_account.click(function(){
            if ($mbMenu_account.hasClass('mb-menu__item-active')) {
                $mbMenu_account.removeClass(itemActiveClass);
                if ($activeItem) {
                    $activeItem.addClass(itemActiveClass);
                }
            }
        });
        $mbMenu_account.popup({
            scroll: false,
            fillEdge: true,
            caption: isLogin ? lang.account : '',
            content: isLogin
                ? $('.account-menu-content:first').clone()
                : $('<div class="d-flex flex-column justify-content-center flex-fill">').append(
                    $('<h3>', {class: 'mb-2'}).text(lang.login),
                    $('#login_modal_source > .tmp-dom').clone(true, true)
                ),
            width: 320,
            onShow: function(){
                $activeItem = $mbMenu.find('.' + itemActiveClass);
                $mbMenu.find('.' + itemActiveClass).removeClass(itemActiveClass);
                $mbMenu_account.addClass(itemActiveClass);
            },
            onClose: function(){
                $mbMenu_account.removeClass(itemActiveClass);
                if ($activeItem) {
                    $activeItem.addClass(itemActiveClass);
                }

                this.destroy();
            }
        });
    });
});

{/literal}
</script>

<div class="mb-menu mb-menu_visible d-flex d-md-none w-100 position-fixed align-items-center{if !$config.mobile_footer_menu_icon_captions} mb-menu_no-captions{/if}{if !$config.mobile_footer_menu_hide_on_scroll} mb-menu_no-hide{/if}">
    {foreach from=$_mobileFooterMenu item='mobile_menu_item' key='mobile_menu_icon'}
        {if ($mobile_menu_item.page && !isset($pages[$mobile_menu_item.page]))
        || ($mobile_menu_icon == 'user' && !isset($pages.login))}{continue}{/if}

        <{if $mobile_menu_item.page}a href="{pageUrl key=$mobile_menu_item.page}"{else}div{/if} class="mb-menu__item d-flex align-items-center justify-content-center h-100{if $mobile_menu_item.page && $pageInfo.Key == $mobile_menu_item.page} mb-menu__item-active{/if}{if $mobile_menu_item.class} mb-menu__item-{$mobile_menu_item.class}{/if}">
            <div class="mb-menu__item-wrapper d-flex flex-column align-items-center position-relative">
                <svg viewBox="0 0 24 24" class="mb-menu__icon">
                   <use xlink:href="#mb-menu-icon-{$mobile_menu_icon}"></use>
                </svg>

                {if $mobile_menu_icon == 'chat' && $new_messages}<span class="mb-menu__counter">{$new_messages}</span>{/if}

                {if $config.mobile_footer_menu_icon_captions}
                    <span class="mb-menu__name text-center">{phrase key=$mobile_menu_item.name}</span>
                {/if}
            </div>
        </{if $mobile_menu_item.page}a{else}div{/if}>
    {/foreach}
</div>
<div class="mb-menu-crossbar d-md-none"></div>

<!-- mobile menu end -->
