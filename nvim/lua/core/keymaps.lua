
local keymap = vim.keymap

keymap.set("n", "<c-a>", "ggVG")

keymap.set({ "n", "x" }, "<leader>p", '"*p')

keymap.set({ "n" }, "<leader>h", "<c-w>h")
keymap.set({ "n" }, "<leader>l", "<c-w>l")
keymap.set({ "n" }, "<leader>j", "<c-w>j")
keymap.set({ "n" }, "<leader>k", "<c-w>k")

keymap.set({ "n" }, "sl", "<cmd>vsplit<CR>")
keymap.set({ "n" }, "sj", "<cmd>split<CR>")
keymap.set({ "n" }, "<leader>e","<cmd>Yazi toggle<CR>")
keymap.set('n', '<A-j>', '<C-o>', { noremap = true, silent = true })
keymap.set('n', '<A-k>', '<C-i>', { noremap = true, silent = true })
