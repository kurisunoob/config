require("lualine").setup({
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "filename", path = 3 } },
		lualine_c = { "branch", "diff", "diagnostics" },
		lualine_x = { "encoding", "fileformat" },
		lualine_y = { "filesize" },
		lualine_z = { "filetype", "progress" },
	},
})
