<?php

/******************************************************************************
 *  
 *  PROJECT: Flynax Classifieds Software
 *  VERSION: 4.10.2
 *  LICENSE: RU369ICO7T19 - https://www.flynax.ru/user-agreement.html
 *  PRODUCT: General Classifieds
 *  DOMAIN: uz24.store
 *  FILE: SETTINGS.TPL.PHP
 *  
 *  The software is a commercial product delivered under single, non-exclusive,
 *  non-transferable license for one domain or IP address. Therefore distribution,
 *  sale or transfer of the file in whole or in part without permission of Flynax
 *  respective owners is considered to be illegal and breach of Flynax License End
 *  User Agreement.
 *  
 *  You are not allowed to remove this information from the file without permission
 *  of Flynax respective owners.
 *  
 *  Flynax Classifieds Software 2026 | All copyrights reserved.
 *  
 *  https://www.flynax.ru
 ******************************************************************************/

/* template settings */
$tpl_settings = array(
    'type' => 'responsive_42', // DO NOT CHANGE THIS SETTING
    'version' => 1.1,
    'name' => 'general_sunny_nova_wide',
    'inventory_menu' => false,
    'category_menu' => true,
    'category_menu_listing_type' => true,
    'right_block' => false,
    'long_top_block' => false,
    'featured_price_tag' => true,
    'ffb_list' => false, //field bound boxes plugins list
    'fbb_custom_tpl' => true,
    'header_banner' => true,
    'header_banner_size_hint' => '728x90',
    'home_page_gallery' => false,
    'home_page_slides' => true,
    'home_page_slides_size' => '1920x1080',
    'home_page_load_more_button' => true,
    'autocomplete_tags' => true,
    'category_banner' => false,
    'listing_type_color' => true,
    'shopping_cart_use_sidebar' => true,
    'listing_details_anchor_tabs' => true,
    'search_on_map_page' => true,
    'home_page_map_search' => false,
    'home_page_hide_main_menu' => false,
    'browse_add_listing_icon' => false,
    'listing_grid_except_fields' => array('title', 'bedrooms', 'bathrooms', 'square_feet', 'time_frame', 'phone', 'pay_period'),
    'category_dropdown_search' => true,
    'sidebar_sticky_pages' => array('listing_details'),
    'sidebar_restricted_pages' => array('search_on_map'),
    'svg_icon_fill' => true,
    'dark_mode' => true,
    'default_listing_grid_mode' => 'grid',
    'listing_grid_mode_only' => false,
    'listing_picture_slider' => true,
    'qtip' => array(
        'background' => 'c60d73',
        'b_color'    => 'c60d73',
    ),
    'font_family' => [
        'local' => true,
        'name' => 'Onest',
        'format' => 'woff2',
        'weights' => [
            '300' => 'Onest-Light',
            '400' => 'Onest-Regular',
            '500' => 'Onest-Medium',
            '600' => 'Onest-SemiBold',
        ]
    ]
);

// Add city field to except array
if ($config['general_sunny_city_field']) {
    $tpl_settings['listing_grid_except_fields'][] = $config['general_sunny_city_field'];
}

if ( is_object($rlSmarty) ) {
    $rlSmarty->assign_by_ref('tpl_settings', $tpl_settings);
}

if (method_exists($GLOBALS['rlHook'], 'addCustomHook')) {
    $GLOBALS['rlHook']->addCustomHook('homeBottom', function() {
        global $category_menu, $rlListingTypes;
        
        $has_category_menu = false;

        foreach ($category_menu as &$menu_item) {
            $type = $rlListingTypes->types[$menu_item['Type']];
            if ($menu_item['isListingType']) {
                if ($type['Icon'] && $type['Menu']) {
                    $menu_item['Icon'] = $type['Icon'];
                    $has_category_menu = true;
                }
            } else {
                if ($menu_item['Icon'] && $type['Menu']) {
                    $has_category_menu = true;
                }
            }
        }

        $GLOBALS['rlSmarty']->assign('has_category_menu', $has_category_menu);
    });
}

// Set demo category icons
if ($plugins['categories_icons'] && !isset($config['general_fusion_support'])) {
    $rlDb->insertOne([
        'Group_ID' => 0,
        'Position' => 0,
        'Key' => 'general_fusion_support',
        'Default' => '1',
        'Type' => 'text',
        'Plugin' => $tpl_settings['type']
    ], 'config');

    $category_mapping = [
        'housekeeping' => '3dicons-roll-brush.webp',
        'pets' => '3dicons-cat.webp',
        'car_service_repair' => '3dicons-tools.webp',
        'health_beauty_fitness' => '3dicons-gym.webp',
        'computers' => '3dicons-computer.webp',
        'education_training_courses' => '3dicons-notebook.webp',
        'home_and_garden' => '3dicons-garden-tools.webp',
        'goods_for_children' => '3dicons-candy.webp',
        'electronics' => '3dicons-headphone.webp',
        'vacancies' => '3dicons-wallet.webp',
        'cars' => '3dicons-car.webp',
    ];

    $tpl_root = RL_ROOT . 'templates' . RL_DS . $config['template'] . RL_DS;

    foreach ($category_mapping as $cat_key => $icon) {
        if (!$rlDb->getOne('Icon', "`Key` = '{$cat_key}'", 'categories')) {
            $rlDb->updateOne([
                'fields' => ['Icon' => $icon, 'Menu' => '1'],
                'where' => ['Key' => $cat_key],
            ], 'categories');
            copy($tpl_root . 'img' . RL_DS . 'icons' . RL_DS . $icon, RL_FILES . $icon);
        }
    }

    $property = $rlDb->fetch(['ID', 'Icon'], ['Key' => 'property'], null, 1, 'listing_types', 'row');
    if ($property && !$property['Icon']) {
        $icon = '3dicons-property.webp';
        $rlDb->updateOne([
            'fields' => ['Icon' => $icon, 'Menu' => '1'],
            'where' => ['Key' => 'property'],
        ], 'listing_types');
        copy($tpl_root . 'img' . RL_DS . 'icons' . RL_DS . $icon, RL_FILES . $icon);
    }
}

// insert config setting related data
if (!isset($config['general_sunny_support'])) {
    $reefless->loadClass('Lang');
    $lang_keys = [];
    $languages = $rlLang->getLanguagesList();
    $tpl_phrases = array(
        array('frontEnd', 'sunny_theme_light', 'Light Theme'),
        array('frontEnd', 'sunny_theme_dark', 'Dark Theme'),
        array('frontEnd', 'all_categores', 'All Categories'),
        array('admin', 'config+name+general_sunny_city_field', 'City field', 'settings'),
    );

    // Insert template phrases
    foreach ($languages as $language) {
        foreach ($tpl_phrases as $tpl_phrase) {
            if (!$rlDb->getOne('ID', "`Code` = '{$language['Code']}' AND `Key` = '{$tpl_phrase[1]}'", 'lang_keys')) {
                $lang_keys[] = [
                    'Code' => $language['Code'],
                    'JS' => '1',
                    'Module' => $tpl_phrase[0],
                    'Key' => $tpl_phrase[1],
                    'Value' => $rlValid->xSql($tpl_phrase[2]),
                    'Plugin' => $tpl_settings['type'],
                    'Target_key' => $tpl_phrase[3] ?: '',
                ];
            }
        }
    }

    $rlLang->createPhrases($lang_keys);

    // Insert config
    $rlDb->insert([
        [
            'Group_ID' => 0,
            'Position' => 0,
            'Key' => 'general_sunny_support',
            'Default' => '1',
            'Type' => 'text',
            'Plugin' => $tpl_settings['type']
        ], [
            'Group_ID' => 5,
            'Position' => 25,
            'Key' => 'general_sunny_city_field',
            'Default' => 'country_level2',
            'Type' => 'select',
            'Plugin' => $tpl_settings['type']
        ]
    ], 'config');

    // insert hooks
    $sql = <<< MYSQL
INSERT INTO `{db_prefix}hooks` (`Name`, `Plugin`, `Class`, `Code`, `Status`) VALUES
('apMixConfigItem', 'general_sunny', '', 'if (\$param1[\'Key\'] == \'general_sunny_city_field\') {\r\n    \$fields = \$GLOBALS[\'rlDb\']->fetch(\r\n        array(\'Key`, `Key` AS `ID\'),\r\n        array(\'Type\' => \'select\'),\r\n        \"OR `Type` = \'text\' ORDER BY `Key`\",\r\n        null, \'listing_fields\'\r\n    );\r\n\r\n    if (\$fields) {\r\n        \$param2[] = \'general_sunny_city_field\';\r\n        \$param1[\'Values\'] = \$GLOBALS[\'rlLang\']->replaceLangKeys(\$fields, \'listing_fields\', \'name\');\r\n    } else {\r\n        \$param1[\'Values\'][0] = \$GLOBALS[\'lang\'][\'not_available\'];\r\n    }\r\n}', 'active'),
('ajaxRequest', 'general_sunny', '', 'global \$rlDb, \$reefless, \$rlListingTypes, \$rlLang;\r\n\r\nif (\$param2 != \'smartSearch\') {\r\n    return;\r\n}\r\n\r\n\$results_limit = 12 / 2;\r\n\$min_length = 3;\r\n\$query = \$_REQUEST[\'query\'];\r\n\r\nif (!\$query || strlen(\$query) <= \$min_length) {\r\n    return;\r\n}\r\n\r\n\$lang_code = RL_LANG_CODE;\r\n\$query_array = explode(\' \', \$query);\r\n\$keywords_query = \'\';\r\n\$categories = [];\r\n\$keywords = [];\r\n\$min = \$min_length;\r\n\r\nif (count(\$query_array) > 1) {\r\n    \$keywords_query .= \"AND (\";\r\n    foreach (\$query_array as \$keyword) {\r\n        if (!\$keyword || strlen(\$keyword) < \$min) {\r\n            continue;\r\n        }\r\n\r\n        \$keywords_query .= \"(`Value` LIKE \'%{\$keyword}\' OR `Value` LIKE \'%{\$keyword} %\') OR \";\r\n        \$min--; // Reduce min length filter to search more relevant categories\r\n    }\r\n    \$keywords_query = substr(\$keywords_query, 0, -4);\r\n    \$keywords_query .= \")\";\r\n} else {\r\n    \$keywords_query = \"AND `Value` LIKE \'%{\$query}%\'\";\r\n}\r\n\r\n// Search in categories\r\n\$sql = \"\r\n    SELECT `Value`, REPLACE(`Key`, \'categories+name+\', \'\') AS `Key` FROM `{db_prefix}lang_keys`\r\n    WHERE `Module` = \'category\' AND `Key` LIKE \'categories+name+%\' AND `Code` = \'{\$lang_code}\'\r\n    {\$keywords_query}\r\n    LIMIT {\$results_limit}\r\n\";\r\n\$categories_names = \$rlDb->getAll(\$sql, [\'Key\', \'Value\']);\r\n\$categories_keys = array_keys(\$categories_names);\r\n\$categories_data = \$rlDb->getAll(\"\r\n    SELECT * FROM `{db_prefix}categories`\r\n    WHERE `Key` IN (\'\" . implode(\"\',\'\", \$categories_keys) . \"\') AND `Status` = \'active\'\r\n\", [\'Key\', true]);\r\n\r\nforeach (\$categories_names as \$key => \$name) {\r\n    /**\r\n     * @todo remove \'name\' index once applying function to simple array foreach {{:}} issue is resolved\r\n     */\r\n    \$names = [\r\n        [\'name\' => \$rlListingTypes->types[\$categories_data[\$key][\'Type\']][\'name\']]\r\n    ];\r\n    if (\$categories_data[\$key][\'Parent_keys\']) {\r\n        \$parent_key = array_pop(explode(\',\', \$categories_data[\$key][\'Parent_keys\']));\r\n        \$names[] = [\'name\' => \$rlLang->getPhrase(\'categories+name+\' . \$parent_key)];\r\n    }\r\n    \$names[] = [\'name\' => \$name];\r\n    \$categories[] = [\r\n        \'names\' => \$names,\r\n        \'url\' => \$reefless->getCategoryUrl(\$categories_data[\$key])\r\n    ];\r\n}\r\n\r\n// Search keywords\r\n\$text_fields = \$rlDb->getAll(\"\r\n    SELECT `T1`.`Key` FROM `{db_prefix}listing_fields` AS `T1`\r\n    LEFT JOIN `{db_prefix}listing_titles` AS `T2` ON `T1`.`ID` = `T2`.`Field_ID`\r\n    WHERE `T1`.`Status` = \'active\' AND `T1`.`Type` = \'text\' AND `T2`.`ID` IS NOT NULL\r\n    GROUP BY `T1`.`Key`\r\n\", [false, \'Key\']);\r\n\r\n\$keywords_query = \'\';\r\n\$min = \$min_length;\r\n\r\nif (count(\$query_array) > 1) {\r\n    \$query_items = \$query_array;\r\n    foreach (\$query_items as \$index => \$item) {\r\n        if (strlen(\$item) < \$min) {\r\n            unset(\$query_items[\$index]);\r\n        }\r\n    }\r\n    foreach (\$text_fields as \$field) {\r\n        \$keywords_query .= \"(`{\$field}` LIKE \'%\" . implode(\"%\' AND `{\$field}` LIKE \'%\", \$query_items) . \"%\') OR \";\r\n    }\r\n    \$keywords_query = substr(\$keywords_query, 0, -4);\r\n} else {\r\n    \$keywords_query = \"`\" . implode(\"` LIKE \'%{\$query}%\' OR `\", \$text_fields) . \"` LIKE \'%{\$query}%\'\";\r\n}\r\n\r\n\$sql = \"\r\n    SELECT `\" . implode(\'`,`\', \$text_fields) . \"` FROM `{db_prefix}listings`\r\n    WHERE `Status` = \'active\' AND ({\$keywords_query})\r\n    LIMIT {\$results_limit}\r\n\";\r\n\$listing_keywords = \$rlDb->getAll(\$sql);\r\n\r\nif (\$listing_keywords) {\r\n    foreach (\$listing_keywords as \$listing) {\r\n        foreach (\$listing as \$keyword) {\r\n            if (\$keyword) {\r\n                \$keywords[] = substr(\$keyword, 0, 2) == \'{|\'\r\n                ? \$reefless->parseMultilingual(\$keyword, \$lang_code)\r\n                : \$keyword;\r\n            }\r\n        }\r\n    }\r\n\r\n    if (\$keywords) {\r\n        \$keywords = array_values(array_unique(\$keywords));\r\n\r\n        /**\r\n         * @todo remove this code once applying function to simple array foreach {{:}} issue is resolved\r\n         */\r\n        \$tmp = [];\r\n        foreach(\$keywords as \$keyword) {\r\n            \$tmp[] = [\'name\' => \$keyword];\r\n        }\r\n        \$keywords = \$tmp;\r\n        unset(\$tmp);\r\n    }\r\n}\r\n\r\n\$param1 = [\r\n    \'status\' => \'OK\',\r\n    \'categories\' => \$categories,\r\n    \'keywords\' => \$keywords\r\n];', 'active');
MYSQL;
    $rlDb->query($sql);

    // Update page for fetch new data in system
    if (defined('REALM') && REALM == 'admin') {
        $reefless->referer();
    }
}
