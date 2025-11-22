require("Comment").setup()

local keymap = vim.keymap
-- Comment
keymap.set("n", "<C-/>", function()
	require("Comment.api").toggle.linewise.current()
end, { desc = "Comment Toggle" })

keymap.set(
	"v",
	"<C-/>",
	"<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Comment Toggle" }
)
