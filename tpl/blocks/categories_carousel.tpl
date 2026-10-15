<!-- categories carousel -->

{if $category_menu}
    {addCSS file=$smarty.const.RL_LIBS_URL|cat:'fancyapps/carousel.css'}

    {assign var='category_parent_ids' value=','|explode:$category.Parent_IDs}

    <section class="point1 mx-auto carousel categories-carousel mt-2 mt-md-4 pt-3">
        <div class="f-carousel__viewport overflow-hidden">
            <div class="f-carousel__track categories-carousel__track d-flex">
                {foreach from=$category_menu item='item'}
                    {if !$item.Icon}{continue}{/if}
                <div class="f-carousel__slide categories-carousel__item text-center">
                    <a href="{$item.href}" id="{$item.Key}" class="categories-carousel__item-link d-block mr-1 mr-md-3">
                        <div class="categories-carousel__item-icon position-relative mb-1">
                            <span class="categories-carousel__item-icon-bg"></span>
                            <img src="{$smarty.const.RL_FILES_URL}{$item.Icon}" alt="{$item.Name}" decoding="async" />
                        </div>
                        {$item.Name}
                   </a>
                </div>
                {/foreach}
            </div>
        </div>
    </section>

    <script class="fl-js-dynamic">
    {literal}

    flUtil.loadScript(rlConfig['libs_url']+'fancyapps/carousel.umd.js', function(){
        new Carousel($('.categories-carousel').get(0), {
            direction: rlLangDir,
            Navigation: true,
            slidesPerPage: 3,
            Dots: false,
            Autoplay: false,
            center: false
        });
    });

    {/literal}
    </script>
{/if}

<!-- categories carousel -->
