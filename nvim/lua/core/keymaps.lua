local keymap = vim.keymap

keymap.set("n", "<c-a>", "ggVG")

keymap.set({ "n", "x" }, "<leader>p", '"*p')

keymap.set({ "n" }, "<leader>h", "<c-w>h")
keymap.set({ "n" }, "<leader>l", "<c-w>l")
keymap.set({ "n" }, "<leader>j", "<c-w>j")
keymap.set({ "n" }, "<leader>k", "<c-w>k")

keymap.set({ "n" }, "sl", "<cmd>vsplit<CR>")
keymap.set({ "n" }, "sj", "<cmd>split<CR>")
keymap.set({ "n" }, "<leader>e", "<cmd>Yazi toggle<CR>")
keymap.set("n", "<A-j>", "<C-o>", { noremap = true, silent = true })
keymap.set("n", "<A-k>", "<C-i>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		local builtin = require("telescope.builtin")

		-- 【跳转与查看】
		vim.keymap.set("n", "gd", builtin.lsp_definitions, opts) -- 转到定义
		vim.keymap.set("n", "gr", builtin.lsp_references, opts) -- 查找所有引用
		vim.keymap.set("n", "gI", builtin.lsp_implementations, opts) -- 转到接口实现
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- 显示悬浮文档
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts) -- 查看函数签名提示

		-- 【重构与修复】
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- 变量/函数重命名
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- 快速修复 (Quick Fix)

		-- 【错误诊断】
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- 跳转到上一个报错
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- 跳转到下一个报错
	end,
})
