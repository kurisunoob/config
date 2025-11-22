-- ~/.config/nvim/lua/plugins/lsp/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    ---------------------------------------
    -- capabilities / cmp
    ---------------------------------------
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    ---------------------------------------
    -- on_attach (你的原版完整保留)
    ---------------------------------------
    local on_attach = function(client, bufnr)
      local bufmap = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
      end

      bufmap("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      bufmap("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      bufmap("n", "gr", vim.lsp.buf.references, "Goto References")
      bufmap("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      bufmap("n", "K", vim.lsp.buf.hover, "Hover")
      bufmap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
      bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
      bufmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      bufmap("n", "<leader>df", vim.diagnostic.goto_next, "Next Diagnostic")
      bufmap("n", "<leader>dF", vim.diagnostic.goto_prev, "Prev Diagnostic")
      bufmap("n", "<leader>dd", vim.diagnostic.open_float, "Float Diagnostic")

      if client.supports_method("textDocument/formatting") then
        bufmap("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "Format Buffer")
      end
    end

    ---------------------------------------
    -- 通用 root_dir（自动匹配项目）
    ---------------------------------------
    local function root_dir()
      return vim.fs.root(0, {
        ".git",
        "package.json",
        "pyproject.toml",
        "requirements.txt",
        "*.sln",
        "*.csproj",
      })
    end

    ---------------------------------------
    -- 工具函数：启动 LSP（Neovim 0.11 标准）
    ---------------------------------------
    local function start_server(config)
      vim.lsp.start(vim.tbl_extend("force", {
        root_dir = root_dir(),
        on_attach = on_attach,
        capabilities = capabilities,
      }, config))
    end

    ---------------------------------------
    -- ========== C / C++ ==========
    ---------------------------------------
    start_server({
      name = "clangd",
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
    })

    ---------------------------------------
    -- ========== C# / OmniSharp ==========
    ---------------------------------------
    start_server({
      name = "omnisharp",
      cmd = {
        "dotnet",
        vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll"
      },

      filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },

      settings = {
        RoslynExtensionsOptions = {
          enableAnalyzersSupport = true,
          enableImportCompletion = true,
          organizeImportsOnFormat = true,
        },
        FormattingOptions = {
          enableEditorConfigSupport = true,
        },
      },
    })

    ---------------------------------------
    -- ========== Python / Pyright ==========
    ---------------------------------------
    start_server({
      name = "pyright",
      cmd = { vim.fn.stdpath("data") .. "/mason/packages/pyright/node_modules/.bin/pyright-langserver", "--stdio" },

      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
          },
        },
      },
    })

    ---------------------------------------
    -- 你以后可以自己加：
    -- start_server({ name="lua_ls", cmd={...}, settings={...} })
    ---------------------------------------
  end,
}

