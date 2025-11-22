-- ~/.config/nvim/lua/plugins/tools/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6", -- 你原来用的稳定版，保持不变
  dependencies = {
    "nvim-lua/plenary.nvim",
    "ahmedkhalf/project.nvim",              -- projects 插件依赖
    "tom-anders/telescope-vim-bookmarks.nvim", -- 你原来用了书签扩展
    -- 可选：超爽扩展（强烈推荐加）
    "nvim-telescope/telescope-fzf-native.nvim", build = "make",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    { "<leader>fp", "<cmd>Telescope projects<cr>",   desc = "Projects" },
    -- 下面这些是你可能会后悔没开的（2025 年必备）
    { "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy Find in Buffer" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help Tags" },
    { "<leader>fm", "<cmd>Telescope marks<cr>",      desc = "Marks" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>",    desc = "Keymaps" },
    { "<leader>fr", "<cmd>Telescope resume<cr>",     desc = "Resume Last Picker" },
    { "<leader>bb", "<cmd>Telescope vim_bookmarks all<cr>", desc = "Bookmarks" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        -- 你原来的核心配置 100% 保留 + 小优化
        file_ignore_patterns = {
          "^.git/",
          "lazy%-lock.json",
          "*-lock.yaml",
          "node_modules/",
          "%.lock$",
          "codegen.ts",
        },
        dynamic_preview_title = true,
        path_display = { "smart" },
        preview = { treesitter = true },

        mappings = {
          i = {
            ["<esc>"] = actions.close,        -- esc 直接关闭（很多人喜欢）
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-down>"] = actions.cycle_history_next,
            ["<C-up>"] = actions.cycle_history_prev,
          },
          n = {
            ["q"] = actions.close,
          },
        },

        -- 你原来的 hooks（和 barbar/tabscope 完美兼容）
        hooks = {
          pre_tab_leave = function()
            vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabLeavePre" })
          end,
          post_tab_enter = function()
            vim.api.nvim_exec_autocmds("User", { pattern = "ScopeTabEnterPost" })
          end,
        },
      },

      pickers = {
        find_files = {
          hidden = true,         -- 显示隐藏文件
          no_ignore = false,     -- 尊重 .gitignore
        },
        buffers = {
          sort_mru = true,       -- 最近最多用排前面
          ignore_current_buffer = true,
        },
      },

      layout_config = {
        horizontal = {
          preview_cutoff = 100,
          preview_width = 0.55,  -- 稍微宽一点预览更爽
        },
        vertical = {
          mirror = false,
        },
        width = 0.9,
        height = 0.9,
      },
    })

    -- 加载你原来的扩展
    pcall(telescope.load_extension, "projects")
    pcall(telescope.load_extension, "vim_bookmarks")
    -- 如果你加了 fzf-native（超快！推荐）：
    pcall(telescope.load_extension, "fzf")
  end,
}
