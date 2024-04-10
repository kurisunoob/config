vim.g.bookmark_sign = "♥"
vim.g.bookmark_highlight_lines = 1

require("telescope").load_extension("vim_bookmarks")

local keymap = vim.keymap

keymap.set("n", "ma", '<cmd>lua require("telescope").extensions.vim_bookmarks.all()<cr>')
keymap.set("n", "mc", '<cmd>lua require("telescope").extensions.vim_bookmarks.current_file()<cr>')
keymap.set("n", "mx", "<cmd>BookmarkClear<cr>")
keymap.set("n", "ml", "<cmd>BookmarkClearAll<cr>")
