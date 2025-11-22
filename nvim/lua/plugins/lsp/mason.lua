-- ~/.config/nvim/lua/plugins/lsp/mason.lua
return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = { "Mason", "MasonInstall", "MasonUpdate" }, -- 懒加载，只有手动调用时才加载
  event = { "BufReadPre", "BufNewFile" },          -- 文件打开时自动准备
  config = function()
    require("mason").setup({
      ui = {
        width = 0.8,
        height = 0.8,
        border = "rounded",               -- 2025 年美观标配
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        keymaps = {
          toggle_package_expand = "<CR>",
          install_package = "i",
          update_package = "u",
          check_package_version = "c",
          update_all_packages = "U",     -- 一键更新全部（神键！）
          check_outdated_packages = "C",
          uninstall_package = "X",
          cancel_installation = "<C-c>",
          apply_language_filter = "f",
        },
      },
      log_level = vim.log.levels.INFO,
      max_concurrent_installers = 10,    -- 加速并行安装
    })

    require("mason-lspconfig").setup({
      -- 自动安装你常用的 LSP（以后再加语言直接在这里加一行）
      ensure_installed = {
        "lua_ls",          -- 替代 sumneko_lua
        "pyright",
        "bashls",
        "clangd",
        "omnisharp",       -- C#
        "cssls",
        "html",
        "jsonls",
        "marksman",        -- Markdown
        "taplo",           -- TOML
        "yamlls",
      },
      automatic_installation = true,  -- 缺少时自动安装（超爽）
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatter
        "stylua",          -- Lua
        "prettierd",       -- JS/TS/CSS/JSON/HTML/MD
        "black",           -- Python
        "isort",           -- Python import 排序
        "clang-format",    -- C/C++
        "csharpier",       -- C# 神器（比 omnisharp 自带强太多）
        "shfmt",           -- Shell
        "markdownlint",

        -- Linter
        -- "eslint_d",        -- JS/TS
        "shellcheck",
        "cpplint",
        "pylint",

        -- DAP (调试)
        -- "codelldb",        -- Rust/C/C++
        -- "debugpy",         -- Python
        -- "netcoredbg",      -- C#

        -- 其他工具
        -- "delve",           -- Go（备用）
      },
      auto_update = true,              -- 每次 Neovim 启动自动检查更新
      run_on_start = true,             -- 启动时自动安装缺失的
      start_delay = 3000,              -- 延迟 3 秒，避免卡启动
      debounce_hours = 12,             -- 12 小时内不再重复检查更新
    })
  end,
}
