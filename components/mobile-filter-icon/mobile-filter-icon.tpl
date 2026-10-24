<!-- mobile filter icon -->

{include file=$componentDir|cat:'mobile-filter-icon/filter-icon.svg'}

<svg viewBox="0 0 24 24" class="filter-icon mr-3 d-block d-lg-none" role="button" tabindex="0" aria-label="{$lang.search|escape}">
    <use xlink:href="#filter-icon"></use>
</svg>

<div class="filter-container h-100 w-100 position-fixed flex-column d-none">
    <div class="d-flex align-items-center filter-container__header align-items-center pl-3 pr-3">
        <div class="filter-container__header-title">{$lang.search}</div>
        <svg viewBox="0 0 12 12" class="filter-container__header-close p-3" role="button" tabindex="0" aria-label="{$lang.close|default:'Close'}">
            <use xlink:href="#close-icon"></use>
        </svg>
    </div>
    <div class="filter-container__body d-flex flex-column scrollbar flex-fill"></div>
</div>

<script class="fl-js-dynamic">
{literal}

$(function(){
    if ($('#wrapper > .filter-container').length) {
        return;
    }

    var $filterCont = $('.filter-container');
    var $header = $filterCont.find('.filter-container__header');
    var $title = $header.find('.filter-container__header-title');
    var $close = $header.find('.filter-container__header-close');
    var $body = $filterCont.find('.filter-container__body');
    var $backgroundConts = $('#main_container,.page-footer,.page-header');

    var openClass = 'filter-container_opened';
    var headerHight = 0;

    // Move container to the wrapper to avoid grid navbar styles conflict
    $('#wrapper').append($filterCont);

    // Icon click handler
    $('body').on('click', '.filter-icon', function(){
        $filterCont.toggleClass(openClass);
        $backgroundConts.toggleClass('d-none');
        headerHight = $header.height() - 20;
    });
    $close.off('click').on('click', function(){
        $filterCont.removeClass(openClass);
        $backgroundConts.removeClass('d-none');
    });

    // Filter box handler
    var $asideLeft = $('aside.left');
    var $filterBoxes = $asideLeft.find('section.filter-box');

    // Change box caption
    var $firstCaption = $filterBoxes.filter(':first').find('h3');
    if ($firstCaption.length) {
        $title
            .text($firstCaption.text())
            .attr('data-text', $firstCaption.text());

        $('input[type=button].filter-icon').val($firstCaption.text());
    }

    // Scroll handler
    var captionBox = null;
    $body.css({overflowY: 'scroll'}).off('scroll').on('scroll', function(){
        if ($filterCont.hasClass(openClass) && $filterBoxes.length > 1) {
            $filterBoxes.each(function(){
                if ($(this).find('h3:not(.d-none)').length) {
                    var boxHeight = $(this).height();
                    var boxOffset = $(this).offset();
                    
                    if (boxOffset.top < headerHight && boxOffset.top + boxHeight > headerHight) {
                        if (captionBox != this) {
                            $title.text($(this).find('h3').text());
                            captionBox = this;
                        }
                    } else if (captionBox) {
                        $title.text($title.data('text'));
                        captionBox = null;
                    }
                }
            });
        }
    });

    // Reserve space for the button at the container bottom
    if ($filterBoxes.find('.search-button,.align-button').length) {
        $filterCont.addClass('filter-container_has-submit');
    }

    // Move filter boxes
    enquire.unregister("screen and (max-width: 991px)").register("screen and (max-width: 991px)", {
        match: function(){
            $filterCont.removeClass('d-none');
            $filterBoxes.removeClass('d-none');
            $body.append($filterBoxes);

            if ($firstCaption.length) {
                $firstCaption.addClass('d-none');
            }
        },
        unmatch: function(){
            $close.click();
            $filterBoxes.addClass('d-none');
            $filterCont.addClass('d-none');
            $asideLeft.prepend($filterBoxes);

            if ($firstCaption.length) {
                $firstCaption.removeClass('d-none');
            }
        }
    })
});

{/literal}
</script>

<!-- mobile filter icon -->
