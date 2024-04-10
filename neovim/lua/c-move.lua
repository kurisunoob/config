require("move").setup({
	config = function()
		local opts = { noremap = true, silent = true }
		-- Normal-mode commands
		vim.keymap.set("n", "<A-Down>", "<cmd>MoveLine(1)<CR>", opts)
		vim.keymap.set("n", "<A-Up>", "<cmd>MoveLine(-1)<CR>", opts)

		-- Visual-mode commands
		vim.keymap.set("v", "<A-Down>", "<cmd>MoveBlock(1)<CR>", opts)
		vim.keymap.set("v", "<A-Up>", "<cmd>MoveBlock(-1)<CR>", opts)
	end,
})
