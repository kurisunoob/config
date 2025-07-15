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
	-- "nvim-tree/nvim-tree.lua",
  "mikavilpas/yazi.nvim",
	"nvim-tree/nvim-web-devicons",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"stevearc/conform.nvim",
	-- {
	-- 	"windwp/nvim-autopairs",
	-- 	event = "InsertEnter",
	-- 	config = true,
	-- },
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
	-- "RRethy/vim-illuminate",
	"akinsho/toggleterm.nvim",
	"kevinhwang91/nvim-ufo",
	"kevinhwang91/promise-async",
	"folke/which-key.nvim",
	"fedepujol/move.nvim",
	"nvim-treesitter/nvim-treesitter",

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	-- {
	-- 	"folke/flash.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	--  -- stylua: ignore
	--  keys = {
	--    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	--    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	--    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	--    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	--    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	--  },
	-- },
	--
	"simrat39/rust-tools.nvim",
	"nvim-lua/plenary.nvim",
	"mfussenegger/nvim-dap",
	"ahmedkhalf/project.nvim",
	"romgrk/barbar.nvim",
	"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
	"unblevable/quick-scope",
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
 'RaafatTurki/hex.nvim',
})

vim.cmd("colorscheme everforest")
require("base")
require("keymap")
-- require("tree")
require("c-mason")
require("lsp")
require("c-conform")
require("c-telescope")
require("c-cmp")
require("c-term")
require("c-comment")
require("c-bookmark")
-- require("c-cursor")
-- require("c-whichkey")
require("c-ufo")
require("c-move")
require("c-treesitter")
require("c-lualine")
require("lsp-rust")
require("lsp-py")
require("lsp-c")
require("lsp-csharp")
require("c-project")
require("c-neovide")
require("bar")
require("c-yazi")
