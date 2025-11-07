name = "Way to the GAB_ID's Multiversal Madness"
description = "An whole new experience.\nExplore the weird mechanics and multiverse of GAB_ID's, enjoying is characters and new items in your world.\nThank you for downloading the mod.\n¡Enjoy!"
author = "GAB_ID"
version = "1.0"
forumthread = ""

api_version = 10

client_only_mod = false
dst_compatible = true
all_clients_require_mod = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

priority = -1

configuration_options = {
    {
        name = "LANGUAGE",
        label = "Language",
        hover = "The language will show the mod.",
        options = {
            {description = "English", data = "ENGLISH"},
            {description = "Spanish - Español", data = "SPANISH"},
            {description = "Chinese - 中国人", data = "CHINESE"},
            {description = "Russian - Русский", data = "RUSSIAN"},
        },
        default = "ENGLISH"
    },
}