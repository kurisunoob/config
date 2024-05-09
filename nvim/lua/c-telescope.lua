local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fp", "<cmd>Telescope  projects<cr>", {})

require("telescope").setup({
	hooks = {
		pre_tab_leave = function()
			vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabLeavePre" })
		end,

		post_tab_enter = function()
			vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabEnterPost" })
		end,

		-- [other hooks]
	},
	defaults = {
		mappings = {
			i = {
				--				["esc"] = actions.close,
			},
		},
		file_ignore_patterns = {
			"codegen.ts",
			".git",
			"lazy-lock.json",
			"*-lock.yaml",
			"node_modules",
			"%.lock",
		},
		dynamic_preview_title = true,
		path_display = { "smart" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	layout_config = {
		horizontal = {
			preview_cutoff = 100,
			preview_width = 0.5,
		},
	},
})
