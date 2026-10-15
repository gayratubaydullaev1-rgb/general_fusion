<!-- color theme toggle (mobile: lives in the user profile menu) -->

<div class="theme-toggle js-theme-toggle d-flex align-items-center" role="button" tabindex="0">
    <svg viewBox="0 0 16 16" class="theme-toggle__icon" aria-hidden="true">
        <use class="theme-toggle__moon" xlink:href="#theme-moon-icon"></use>
        <use class="theme-toggle__sun" xlink:href="#theme-sun-icon"></use>
    </svg>
    <span class="theme-toggle__label theme-toggle__label_to-dark">{$lang.theme_dark|default:'Dark theme'}</span>
    <span class="theme-toggle__label theme-toggle__label_to-light">{$lang.theme_light|default:'Light theme'}</span>
</div>

<!-- color theme toggle end -->
