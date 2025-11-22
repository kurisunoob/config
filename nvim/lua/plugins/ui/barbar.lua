-- ~/.config/nvim/lua/plugins/ui/barbar.lua
return {
  "romgrk/barbar.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- 可选，但强烈推荐（图标）
    "lewis6991/gitsigns.nvim",     -- 可选，显示 git 状态
  },
  init = function()
    vim.g.barbar_auto_setup = false -- 让我们自己手动 setup，更可控
  end,
  opts = {
    animation = true,              -- 开启切换缓冲区动画（丝滑）
    auto_hide = false,             -- 只有一个 buffer 时不隐藏
    tabpages = true,               -- 显示 tabpage 编号
    clickable = true,              -- 鼠标点击缓冲区可切换
    focus_on_close = "left",       -- 关闭 buffer 后焦点移到左边
    icons = {
      -- 美化图标（everforest 配色超搭）
      buffer_index = true,
      buffer_number = false,
      button = "×",
      diagnostics = { error = " ", warn = " ", info = " ", hint = " " },
      gitsigns = {
        added = "+",
        changed = "~",
        deleted = "-",
      },
      filetype = { enabled = true },
      modified = { button = "●" },
      pinned = { button = " ", filename = true },
      alternate = { filetype = { enabled = false } },
      current = { buffer_index = true },
      inactive = { button = "×" },
      visible = { modified = { button = "●" } },
    },
    sidebar_filetypes = {
      -- yazi 侧边栏兼容
      ["yazi"] = true,
    },
  },

  -- ==================== 你的键位全部移植 + 现代化 ====================
  keys = {
    -- 切换缓冲区
    { "<A-,>", "<cmd>BufferPrevious<cr>",     desc = "Previous Buffer" },
    { "<A-.>", "<cmd>BufferNext<cr>",         desc = "Next Buffer" },

    -- 移动缓冲区位置
    { "<A-<>", "<cmd>BufferMovePrevious<cr>", desc = "Move Buffer Left" },
    { "<A->>", "<cmd>BufferMoveNext<cr>",     desc = "Move Buffer Right" },

    -- 固定/取消固定缓冲区
    { "<A-p>", "<cmd>BufferPin<cr>",          desc = "Pin/Unpin Buffer" },

    -- 关闭缓冲区
    { "<A-c>", "<cmd>BufferClose<cr>",        desc = "Close Buffer" },

    -- 快速挑选缓冲区（你原来的 <C-p>）
    { "<C-p>", "<cmd>BufferPick<cr>",         desc = "Pick Buffer" },

    -- 可选：数字快速跳转（比你原来注释掉的更强，支持 10+）
    { "<A-1>", "<cmd>BufferGoto 1<cr>", desc = "Goto Buffer 1" },
    { "<A-2>", "<cmd>BufferGoto 2<cr>", desc = "Goto Buffer 2" },
    { "<A-3>", "<cmd>BufferGoto 3<cr>", desc = "Goto Buffer 3" },
    { "<A-4>", "<cmd>BufferGoto 4<cr>", desc = "Goto Buffer 4" },
    { "<A-5>", "<cmd>BufferGoto 5<cr>", desc = "Goto Buffer 5" },
    { "<A-6>", "<cmd>BufferGoto 6<cr>", desc = "Goto Buffer 6" },
    { "<A-7>", "<cmd>BufferGoto 7<cr>", desc = "Goto Buffer 7" },
    { "<A-8>", "<cmd>BufferGoto 8<cr>", desc = "Goto Buffer 8" },
    { "<A-9>", "<cmd>BufferGoto 9<cr>", desc = "Goto Buffer 9" },
    { "<A-0>", "<cmd>BufferLast<cr>",   desc = "Goto Last Buffer" },
  },
}
