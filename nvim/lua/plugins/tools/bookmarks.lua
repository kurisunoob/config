-- ~/.config/nvim/lua/plugins/tools/bookmarks.lua
return {
  "MattesGroeger/vim-bookmarks",
  dependencies = {
    "tom-anders/telescope-vim-bookmarks.nvim",
  },
  init = function()
    -- 你原来的全局设置（更现代的写法）
    vim.g.bookmark_sign = "♥"               -- 书签名（可换成    etc）
    vim.g.bookmark_annotation_sign = ""     -- 带注解的书签名（新增，神器！）
    vim.g.bookmark_highlight_lines = 1      -- 高亮整行（保留你最爱的）
    vim.g.bookmark_save_per_working_dir = 1 -- 每个项目独立书签（强烈推荐打开）
    vim.g.bookmark_auto_save = 1            -- 自动保存（不用担心丢）
    vim.g.bookmark_manage_respect_ignore = 1 -- 尊重 .gitignore
    vim.g.bookmark_no_default_key_mappings = 1 -- 关闭默认 mm 键位，我们自己用 Telescope
  end,

  config = function()
    -- 自动加载 Telescope 扩展
    require("telescope").load_extension("vim_bookmarks")
  end,

  keys = {
    -- 你原来的键位 100% 保留 + 优化描述 + 防冲突
    { "ma", '<cmd>lua require("telescope").extensions.vim_bookmarks.all(require("telescope.themes").get_dropdown())<cr>', 
      desc = "Bookmarks: All (dropdown)" },

    { "mc", '<cmd>lua require("telescope").extensions.vim_bookmarks.current_file(require("telescope.themes").get_ivy())<cr>', 
      desc = "Bookmarks: Current File (ivy)" },

    { "mx", "<cmd>BookmarkClear<cr>",     desc = "Bookmarks: Clear Current Line" },
    { "ml", "<cmd>BookmarkClearAll<cr>",  desc = "Bookmarks: Clear All in File" },

    -- 2025 年必备扩展键位（你一定会爱上）
    { "mm", "<cmd>BookmarkToggle<cr>",    desc = "Bookmarks: Toggle (mm 经典回归)" },
    { "mi", "<cmd>BookmarkAnnotate<cr>",  desc = "Bookmarks: Add/Edit Annotation" },
    { "mn", "<cmd>BookmarkNext<cr>",      desc = "Bookmarks: Next" },
    { "mp", "<cmd>BookmarkPrev<cr>",      desc = "Bookmarks: Prev" },
    { "mA", "<cmd>BookmarkShowAll<cr>",   desc = "Bookmarks: Show All (quickfix)" },
  },
}
