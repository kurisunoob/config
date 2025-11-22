return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = { theme = "everforest" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "filename", path = 3 } },
		lualine_c = { "branch", "diff", "diagnostics" },
		lualine_x = { "encoding", "fileformat" },
		lualine_y = { "filesize" },
		lualine_z = { "filetype", "progress" },
	},
}
