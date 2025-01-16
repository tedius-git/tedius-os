local wezterm = require("wezterm")

local act = wezterm.action

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

config.default_workspace = "~"

local OPACITY = {
    transparent = 0.80,
    solid = 1.0,
}

-- Toggle between background opacity
wezterm.on("toggle-opacity", function(window, pane)
    local overrides = window:get_config_overrides() or {}
    overrides.window_background_opacity = overrides.window_background_opacity == OPACITY.solid and OPACITY.transparent
        or OPACITY.solid
    window:set_config_overrides(overrides)
end)

-- General Config
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font_size = 16.0
config.window_background_opacity = OPACITY.solid
config.initial_cols = 120
config.initial_rows = 30
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
-- config.window_decorations = "RESIZE"
config.cursor_blink_rate = 500
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = false
config.scrollback_lines = 5000
config.front_end = "WebGpu"
config.enable_wayland = false

-- Keybindings
config.leader = { key = "s", mods = "CTRL" }

config.keys = {
    { key = "c", mods = "LEADER", action = act.SpawnTab("DefaultDomain") },
    { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = false }) },
    { key = "h", mods = "LEADER", action = act.SplitPane({ direction = "Left" }) },
    { key = "j", mods = "LEADER", action = act.SplitPane({ direction = "Down" }) },
    { key = "k", mods = "LEADER", action = act.SplitPane({ direction = "Up" }) },
    { key = "l", mods = "LEADER", action = act.SplitPane({ direction = "Right" }) },
    { key = "t", mods = "LEADER", action = act.EmitEvent("toggle-opacity") },
    {
        key = "w",
        mods = "ALT",
        action = wezterm.action_callback(function(win, pane)
            resurrect.save_state(resurrect.workspace_state.get_workspace_state())
        end),
    },
    {
        key = "W",
        mods = "ALT",
        action = resurrect.window_state.save_window_action(),
    },
    {
        key = "T",
        mods = "ALT",
        action = resurrect.tab_state.save_tab_action(),
    },
    {
        key = "s",
        mods = "ALT",
        action = wezterm.action_callback(function(win, pane)
            resurrect.save_state(resurrect.workspace_state.get_workspace_state())
            resurrect.window_state.save_window_action()
        end),
    },
    {
        key = "r",
        mods = "ALT",
        action = wezterm.action_callback(function(win, pane)
            resurrect.fuzzy_load(win, pane, function(id, label)
                local type = string.match(id, "^([^/]+)") -- match before '/'
                id = string.match(id, "([^/]+)$") -- match after '/'
                id = string.match(id, "(.+)%..+$") -- remove file extention
                local opts = {
                    relative = true,
                    restore_text = true,
                    on_pane_restore = resurrect.tab_state.default_on_pane_restore,
                }
                if type == "workspace" then
                    local state = resurrect.load_state(id, "workspace")
                    resurrect.workspace_state.restore_workspace(state, opts)
                elseif type == "window" then
                    local state = resurrect.load_state(id, "window")
                    resurrect.window_state.restore_window(pane:window(), state, opts)
                elseif type == "tab" then
                    local state = resurrect.load_state(id, "tab")
                    resurrect.tab_state.restore_tab(pane:tab(), state, opts)
                end
            end)
        end),
    },
}

for i = 1, 8 do
    -- CTRL+ALT + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1),
    })
end

-- Window initial position
wezterm.on("gui-startup", function()
    local tab, pane, window = wezterm.mux.spawn_window({})
    window:gui_window():set_position(170, 80)
end)

workspace_switcher.apply_to_config(config)

tabline.setup({
    options = {
        icons_enabled = true,
        tabs_enabled = true,
        theme_overrides = {
            normal_mode = {
                a = { fg = '#181825', bg = '#a6da95' },
                b = { fg = '#89b4fa', bg = '#1e1e2e' },
                c = { fg = '#cdd6f4', bg = '#1e1e2e' },
            },
            tab = {
                active = { fg = "#cdd6f4", bg = "#313244" },
                inactive = { fg = "#cdd6f4", bg = "#1e1e2e" },
                inactive_hover = { fg = "#f5c2e7", bg = "#313244" },
            },
        },
        section_separators = {
            left = wezterm.nerdfonts.ple_right_half_circle_thick,
            right = wezterm.nerdfonts.ple_left_half_circle_thick,
        },
        component_separators = {
            left = wezterm.nerdfonts.ple_right_half_circle_thick,
            right = wezterm.nerdfonts.ple_left_half_circle_thick,
        },
        tab_separators = {
            left = wezterm.nerdfonts.ple_right_half_circle_thick,
            right = wezterm.nerdfonts.ple_left_half_circle_thick,
        },
    },
    sections = {
        tabline_a = {},
        tabline_b = {},
        tabline_c = {},
        tab_active = { "index", { "process", padding = { left = 0, right = 1 } } },
        tab_inactive = { "index", { "process", padding = { left = 0, right = 1 } } },
        tabline_x = {},
        tabline_y = {},
        tabline_z = { "workspace" },
    },
})

tabline.apply_to_config(config)

smart_splits.apply_to_config(config, {
    direction_keys = { "h", "j", "k", "l" },
    direction_keys = {
        move = { "h", "j", "k", "l" },
        resize = { "LeftArrow", "DownArrow", "UpArrow", "RightArrow" },
    },
    modifiers = {
        move = "CTRL",
        resize = "CTRL",
    },
    log_level = "info",
})

-- loads the state whenever I create a new workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
    local workspace_state = resurrect.workspace_state

    workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
        window = window,
        relative = true,
        restore_text = true,
        on_pane_restore = resurrect.tab_state.default_on_pane_restore,
    })
end)

-- Saves the state whenever I select a workspace
wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
    local workspace_state = resurrect.workspace_state
    resurrect.save_state(workspace_state.get_workspace_state())
end)

return config
