---------------------------
-- Default awesome theme --
--        EDITED         --
-- + zenburn colors icons--
---------------------------
-- Version: 31-12-2017 08:26 MSK
-- Modified:
-- 1. theme.menu.width (ширина меню) увеличено

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
--local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local theme_dir = RC.vars.theme_dir
local wallpaper_dir = RC.vars.wallpaper_dir


local theme = {}


-- Theme fonts {{{
theme.font                 = "DejaVu Sans 8"
theme.serif_font           = "DejaVu Serif 8"
theme.mono_font            = "DejaVu Sans Mono 8"
theme.taglist_font         = "DejaVu Sans Bold 8"
theme.tasklist_font        = "DejaVu Sans Bold 7"
theme.widget_font          = "DejaVu Sans 8"
-- theme.icon_font            = "Webhostinghub-Glyphs 6"
theme.hotkeys_font         = "DegaVu Sans Mono Italic 7"
theme.hotkeys_description_font = "DejaVu Sans Mono 7"

--}}}

-- Theme colours {{{
theme.foreground           = '#eceff1'
theme.background           = '#09212d'
-- theme.cursor               = '#1c222e'
---- new
theme.black1               = '#363636'
theme.black2               = '#121212'
theme.grey1                = '#696969'
theme.grey2                = '#4f4f4f'
theme.red1                 = '#e05a72'
theme.red2                 = '#9c4252'
theme.green1               = '#59b387'
theme.green2               = '#387054'
theme.green3               = '#3e515a'
theme.green4               = '#2a373e'
theme.yellow1              = '#ffffaf'
theme.yellow2              = '#cccc8c'
theme.orange1              = '#e6a15c'
theme.orange2              = '#805f3f'
theme.blue1                = '#5f87af'
theme.blue2                = '#527496'
theme.blue3                = '#335980'
theme.magenta1             = '#aa7fff'
theme.magenta2             = '#7759B3'
theme.cyan1                = '#5fafaf'
theme.cyan2                = '#5f8787'
theme.white1               = '#ffffff'
theme.white2               = '#cccccc'
theme.white3               = '#808080'

-------old-----------------------

theme.bg_normal     = "#3F3F3F"
theme.bg_focus      = "#1E2320"
theme.bg_urgent     = "#3F3F3F"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#DCDCCC"
theme.fg_focus      = "#F0DFAF"
theme.fg_urgent     = "#CC9393"
theme.fg_minimize   = "#3F3F3F"

-- {{{ Borders zenburn
theme.useless_gap   = 0
theme.border_width  = 1
theme.border_normal = "#3F3F3F"
theme.border_focus  = "#6F6F6F"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

--- {{{ tooltips theme settinfgs
theme.tooltip_font = "DejaVu Sans Mono 9"
theme.tooltip_border_width = 0
theme.tooltip_bg = theme.bg_normal
---}}}

-- Generate taglist squares:
local taglist_square_size = 4
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.awesome_icon = theme_dir .. "edited/awesome-icon.png"
theme.menu_submenu_icon = theme_dir.."edited/submenu.png"
theme.menu_height = 16
theme.menu_width  = 130

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- {{{ Titlebar
theme.titlebar_close_button_focus  = theme_dir .. "edited/titlebar/close_focus.png"
theme.titlebar_close_button_normal = theme_dir .. "edited/titlebar/close_normal.png"

theme.titlebar_minimize_button_normal = theme_dir .. "default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme_dir .. "default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_focus_active  = theme_dir .. "edited/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = theme_dir .. "edited/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = theme_dir .. "edited/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = theme_dir .. "edited/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = theme_dir .. "edited/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = theme_dir .. "edited/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = theme_dir .. "edited/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = theme_dir .. "edited/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = theme_dir .. "edited/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = theme_dir .. "edited/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = theme_dir .. "edited/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = theme_dir .. "edited/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = theme_dir .. "edited/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = theme_dir .. "edited/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme_dir .. "edited/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme_dir .. "edited/titlebar/maximized_normal_inactive.png"
-- }}}

theme.wallpaper = wallpaper_dir.."nasa.png"

-- {{{ Layout
theme.layout_tile       = theme_dir .. "edited/layouts/tile.png"
theme.layout_tileleft   = theme_dir .. "edited/layouts/tileleft.png"
theme.layout_tilebottom = theme_dir .. "edited/layouts/tilebottom.png"
theme.layout_tiletop    = theme_dir .. "edited/layouts/tiletop.png"
theme.layout_fairv      = theme_dir .. "edited/layouts/fairv.png"
theme.layout_fairh      = theme_dir .. "edited/layouts/fairh.png"
theme.layout_spiral     = theme_dir .. "edited/layouts/spiral.png"
theme.layout_dwindle    = theme_dir .. "edited/layouts/dwindle.png"
theme.layout_max        = theme_dir .. "edited/layouts/max.png"
theme.layout_fullscreen = theme_dir .. "edited/layouts/fullscreen.png"
theme.layout_magnifier  = theme_dir .. "edited/layouts/magnifier.png"
theme.layout_floating   = theme_dir .. "edited/layouts/floating.png"
theme.layout_cornernw   = theme_dir .. "edited/layouts/cornernw.png"
theme.layout_cornerne   = theme_dir .. "edited/layouts/cornerne.png"
theme.layout_cornersw   = theme_dir .. "edited/layouts/cornersw.png"
theme.layout_cornerse   = theme_dir .. "edited/layouts/cornerse.png"
-- }}}

-- Generate Awesome icon:
--theme.awesome_icon = theme_assets.awesome_icon(
--    theme.menu_height, theme.bg_focus, theme.fg_focus
--)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
--theme.icon_theme = nil

return theme
