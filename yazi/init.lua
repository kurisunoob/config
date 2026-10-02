require("full-border"):setup()
require("starship"):setup()
require("zoxide"):setup({
	update_db = true,
})
-- require("yatline"):setup({
-- 	section_separator = { open = "", close = "" },
-- 	part_separator = { open = "", close = "" },
-- 	inverse_separator = { open = "", close = "" },
--
-- 	style_a = {
-- 		fg = "black",
-- 		bg_mode = {
-- 			normal = "#a89984",
-- 			select = "#d79921",
-- 			un_set = "#d65d0e",
-- 		},
-- 	},
-- 	style_b = { bg = "#665c54", fg = "#ebdbb2" },
-- 	style_c = { bg = "#3c3836", fg = "#a89984" },
--
-- 	permissions_t_fg = "green",
-- 	permissions_r_fg = "yellow",
-- 	permissions_w_fg = "red",
-- 	permissions_x_fg = "cyan",
-- 	permissions_s_fg = "darkgray",
--
-- 	tab_width = 20,
-- 	tab_use_inverse = false,
--
-- 	selected = { icon = "󰻭", fg = "yellow" },
-- 	copied = { icon = "", fg = "green" },
-- 	cut = { icon = "", fg = "red" },
--
-- 	total = { icon = "󰮍", fg = "yellow" },
-- 	succ = { icon = "", fg = "green" },
-- 	fail = { icon = "", fg = "red" },
-- 	found = { icon = "󰮕", fg = "blue" },
-- 	processed = { icon = "󰐍", fg = "green" },
--
-- 	show_background = true,
--
-- 	display_header_line = true,
-- 	display_status_line = true,
--
-- 	header_line = {
-- 		left = {
-- 			section_a = {
-- 				{ type = "line", custom = false, name = "tabs", params = { "left" } },
-- 			},
-- 			section_b = {},
-- 			section_c = {},
-- 		},
-- 		right = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "date", params = { "%A, %d %B %Y" } },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "date", params = { "%X" } },
-- 			},
-- 			section_c = {},
-- 		},
-- 	},
--
-- 	status_line = {
-- 		left = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "tab_mode" },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "hovered_size" },
-- 			},
-- 			section_c = {
-- 				{ type = "string", custom = false, name = "hovered_name" },
-- 				{ type = "coloreds", custom = false, name = "count" },
-- 			},
-- 		},
-- 		right = {
-- 			section_a = {
-- 				{ type = "string", custom = false, name = "cursor_position" },
-- 			},
-- 			section_b = {
-- 				{ type = "string", custom = false, name = "cursor_percentage" },
-- 			},
-- 			section_c = {
-- 				{ type = "string", custom = false, name = "hovered_file_extension", params = { true } },
-- 				{ type = "coloreds", custom = false, name = "permissions" },
-- 			},
-- 		},
-- 	},
-- })
-- You can configure your bookmarks using simplified syntax
local bookmarks = {
	{ tag = "Desktop", path = "~/Desktop", key = "d" },
	{ tag = "Documents", path = "~/Documents", key = "D" },
	{ tag = "Downloads", path = "~/Downloads", key = "o" },
	{ tag = "HyprlandCoinfig", path = "~/.config/hypr/", key = "h" },
	{ tag = "KittyConfig", path = "~/.config/kitty/", key = "k" },
	{ tag = "YaziConfig", path = "~/.config/yazi/", key = "y" },
	{ tag = "NeovimConfig", path = "~/.config/nvim/", key = "v" },
}
-- Windows-specific bookmarks
if ya.target_family() == "windows" then
	local home_path = os.getenv("USERPROFILE")
	table.insert(bookmarks, {
		tag = "Scoop Local",
		path = os.getenv("SCOOP") or (home_path .. "\\scoop"),
		key = "p",
	})
	table.insert(bookmarks, {
		tag = "Scoop Global",
		path = os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop",
		key = "P",
	})
end

require("whoosh"):setup({
	-- Configuration bookmarks (cannot be deleted through plugin)
	bookmarks = bookmarks,

	-- Notification settings
	jump_notify = false,

	-- Key generation for auto-assigning bookmark keys
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",

	-- Configure the built-in menu action hotkeys
	-- false - hide menu item
	special_keys = {
		create_temp = "<Enter>", -- Create a temporary bookmark from the menu
		fuzzy_search = "<Space>", -- Launch fuzzy search (fzf)
		history = "<Tab>", -- Open directory history
		previous_dir = "<Backspace>", -- Jump back to the previous directory
		project_root = "-", -- Jump to the current Git repository root
	},

	-- File path for storing user bookmarks
	bookmarks_path = (
		ya.target_family() == "windows"
		and os.getenv("APPDATA") .. "\\yazi\\config\\plugins\\whoosh.yazi\\bookmarks"
	) or (os.getenv("HOME") .. "/.config/yazi/plugins/whoosh.yazi/bookmarks"),

	-- Replace home directory with "~"
	home_alias_enabled = true, -- Toggle home aliasing in displays

	-- Path truncation in navigation menu
	path_truncate_enabled = false, -- Enable/disable path truncation
	path_max_depth = 3, -- Maximum path depth before truncation

	-- Path truncation in fuzzy search (fzf)
	fzf_path_truncate_enabled = false, -- Enable/disable path truncation in fzf
	fzf_path_max_depth = 5, -- Maximum path depth before truncation in fzf

	-- Long folder name truncation
	path_truncate_long_names_enabled = false, -- Enable in navigation menu
	fzf_path_truncate_long_names_enabled = false, -- Enable in fzf
	path_max_folder_name_length = 20, -- Max length in navigation menu
	fzf_path_max_folder_name_length = 20, -- Max length in fzf

	-- History directory settings
	history_size = 10, -- Number of directories in history (default 10)
	history_fzf_path_truncate_enabled = false, -- Enable/disable path truncation by depth for history
	history_fzf_path_max_depth = 5, -- Maximum path depth before truncation for history (default 5)
	history_fzf_path_truncate_long_names_enabled = false, -- Enable/disable long folder name truncation for history
	history_fzf_path_max_folder_name_length = 30, -- Maximum length for folder names in history (default 30)
})
