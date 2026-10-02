return {
  "seblj/roslyn.nvim",
  ft = "cs",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  init = function()
    -- 在 roslyn.nvim/plugin/roslyn.lua 运行之前覆盖启动命令
    -- （plugin 文件会调 vim.lsp.enable("roslyn")，必须提前覆盖）
    local roslyn_dll = vim.fn.stdpath("data")
      .. "/mason/packages/roslyn/libexec/Microsoft.CodeAnalysis.LanguageServer.dll"
    if vim.fn.filereadable(roslyn_dll) == 1 then
      vim.lsp.config("roslyn", {
        cmd = {
          "dotnet", roslyn_dll, "--stdio",
          "--logLevel=Information",
          "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
        },
      })
    end
  end,
  config = function()
    local roslyn_dll = vim.fn.stdpath("data")
      .. "/mason/packages/roslyn/libexec/Microsoft.CodeAnalysis.LanguageServer.dll"
    if vim.fn.filereadable(roslyn_dll) == 0 then
      vim.notify("Roslyn DLL not found! Please check Mason installation.", vim.log.levels.ERROR)
      return
    end

    require("roslyn").setup()

    -- 补充 settings（cmd 已在 init 中设好了）
    vim.lsp.config("roslyn", {
      settings = {
        ["csharp|completion"] = {
          dotnet_show_completion_items_from_unimported_namespaces = true,
          dotnet_provide_20_2_argument_completion = true,
        },
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
        },
      },
    })
  end,
}
