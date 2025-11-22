-- ~/.config/nvim/lua/plugins/tools/yazi.lua
return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>e", "<cmd>Yazi<cr>", desc = "Yazi: Toggle File Explorer" },
		{ "<leader>E", "<cmd>Yazi cwd<cr>", desc = "Yazi: Open in CWD" },
	},
	opts = {
		open_for_directories = true, -- 目录直接用 yazi 打开
		floating_window_scaling_factor = 0.9,
		yazi_floating_window_winblend = 0,
		keymaps = {
			show_help = "<f1>",
			open_file_in_vertical_split = "<c-v>",
			open_file_in_horizontal_split = "<c-x>",
			open_file_in_tab = "<c-t>",
		},
	},
}
