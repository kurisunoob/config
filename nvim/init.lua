local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	"sainnhe/everforest",
	"nvim-tree/nvim-tree.lua",
	"nvim-tree/nvim-web-devicons",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"stevearc/conform.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	-- init.lua:
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		-- or                              , branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	"mg979/vim-visual-multi",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-vsnip",
	"hrsh7th/vim-vsnip",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"numToStr/Comment.nvim",
	"MattesGroeger/vim-bookmarks",
	"tom-anders/telescope-vim-bookmarks.nvim",
	"yamatsum/nvim-cursorline",
	"akinsho/toggleterm.nvim",
	-- "kevinhwang91/nvim-ufo",
	"kevinhwang91/promise-async",
	"folke/which-key.nvim",
	"fedepujol/move.nvim",
	"nvim-treesitter/nvim-treesitter",
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
})

vim.cmd("colorscheme everforest")
require("base")
require("keymap")
require("tree")
require("c-mason")
require("lsp")
require("c-conform")
require("c-telescope")
require("c-cmp")
require("c-term")
require("c-comment")
require("c-bookmark")
require("c-cursor")
require("c-whichkey")
-- require("c-ufo")
require("c-move")
require("c-treesitter")
require("c-lualine")
