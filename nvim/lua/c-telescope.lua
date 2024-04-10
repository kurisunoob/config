local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

require("telescope").setup({
	--	defaults = {
	--		mappings = {
	--			i = {
	--				--				["esc"] = actions.close,
	--			},
	--		},
	--		file_ignore_patterns = {
	--			"codegen.ts",
	--			".git",
	--			"lazy-lock.json",
	--			"*-lock.yaml",
	--			"node_modules",
	--			"%.lock",
	--		},
	--		dynamic_preview_title = true,
	--		path_display = { "smart" },
	--	},
	--	pickers = {
	--		find_files = {
	--			hidden = true,
	--		},
	--	},
	--	layout_config = {
	--		horizontal = {
	--			preview_cutoff = 100,
	--			preview_width = 0.5,
	--		},
	--	},
})
