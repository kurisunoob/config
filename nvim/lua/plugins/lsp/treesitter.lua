--语法解析树插件
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {"c_sharp",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "markdown",
        "markdown_inline",
      },
      highlight = { enable = true },
      indent = { enable = true },
      sync_install = false,
      auto_install = true,

      ignore_install = { "javascript" },
      additional_vim_regex_highlighting = false,
    })
  end,
}
