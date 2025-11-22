return {
  "numToStr/Comment.nvim",
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    { "<C-/>", "<Plug>(comment_toggle_linewise_current)", mode = "n", desc = "Toggle comment line" },
    { "<C-/>", "<Plug>(comment_toggle_linewise_visual)",  mode = "v", desc = "Toggle comment visual" },
  },
  config = function()
    require("Comment").setup({
      -- 如果你想要预览被注释的代码，可以打开 opleader
      opleader = {
        line = "gc",
        block = "gb",
      },
      toggler = {
        line = "gcc",  -- 默认就有了，可以不写
      },
    })
  end,
}
