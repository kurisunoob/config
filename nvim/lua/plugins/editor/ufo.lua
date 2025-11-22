-- ~/.config/nvim/lua/plugins/editor/ufo.lua
return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "VeryLazy",
  config = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    -- 让所有 LSP 都支持 foldingRange（你原来写的那段）
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }
    local lspconfig = require("lspconfig")
    for _, server in pairs(lspconfig.util.available_servers()) do
      if lspconfig[server] then
        lspconfig[server].setup({ capabilities = capabilities })
      end
    end

    require("ufo").setup({
      provider_selector = function()
        return { "treesitter", "indent" }  -- 2025 最稳组合
      end,
    })

    -- 键位（后面会被 which-key 美化）
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then vim.lsp.buf.hover() end
    end)
  end,
}
