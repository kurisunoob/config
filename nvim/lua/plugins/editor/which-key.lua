-- ~/.config/nvim/lua/plugins/editor/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",                    -- 2025 最流行样式（超美！）
    delay = 400,                         -- 延迟 400ms 显示，敲得快不打扰
    icons = { group = "" },              -- 分组前不加图标，干净
    win = { border = "rounded" },        -- 圆角窗口
  },
  config = function()
    local wk = require("which-key")

    wk.add({
      { "<leader>b", group = "Buffer / Barbar" },
      { "<leader>d", group = "Diagnostic / LSP" },
      { "<leader>f", group = "Find / Telescope" },
      { "<leader>m", group = "Bookmarks" },
      { "<leader>r", group = "Rust / Refactor" },
      { "<leader>u", group = "UI / Notification" },
      { "<leader>e", group = "Explorer / Yazi" },
      { "z", group = "Fold (ufo)" },

      -- 你所有键位都会自动显示，这里可以预注册分组让它更漂亮
      { "<leader>ca", desc = "Code Action" },
      { "<leader>rn", desc = "Rename" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Live Grep" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>fp", desc = "Projects" },
      { "<leader>ma", desc = "Bookmarks All" },
      { "<leader>mc", desc = "Bookmarks Current" },
      { "<leader>un", desc = "Notifications History" },
    })
  end,
}
