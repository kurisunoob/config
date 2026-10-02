-- ~/.config/nvim/lua/plugins/lsp/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -------------------------------------------------------------------
    ---python
    -------------------------------------------------------------------
    vim.lsp.config("pyright", {
      capabilities = capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForType = true,
            typeCheckingMode = "basic",
          },
        },
      },
    })
    vim.lsp.enable("pyright")

    -------------------------------------------------------------------
    ---lua
    -------------------------------------------------------------------
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
    vim.lsp.enable("lua_ls")
  end,
}
