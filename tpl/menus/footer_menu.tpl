<!-- footer menu block -->

{assign var='footer_menu' value=$footer_menu|@array_values}
{math equation='ceil(total/3)' total=$footer_menu|@count assign='per_column'}

{assign var='menu_col_class' value='col-md-4'}
{if $config.ios_app_url || $config.android_app_url}
    {assign var='menu_col_class' value='col-md-3'}
{/if}

{section name='menu_column' loop=3 max=3}
    <ul class="col-sm-4 {$menu_col_class} mb-4">
    	<li class="footer-menu-title">{phrase key='footer_menu_'|cat:$smarty.section.menu_column.iteration}</li>
        {math assign='start' equation='(iter-1)*per_column' iter=$smarty.section.menu_column.iteration per_column=$per_column}
        {section name='item' loop=$footer_menu start=$start max=$per_column}
            {assign var='index' value=$smarty.section.item.index}
            {assign var='menu_item' value=$footer_menu.$index}
            {include file='menus/menu_item.tpl' menuItem=$menu_item itemTag='li'}
        {/section}
    </ul>
{/section}

<!-- footer menu block end -->
