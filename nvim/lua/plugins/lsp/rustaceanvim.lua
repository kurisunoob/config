return {
  "mrcjkb/rustaceanvim",
  version = "^5",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      tools = { hover_actions = { auto_focus = true } },
      server = { on_attach = function(_, bufnr)
        vim.keymap.set("n", "K", "<cmd>RustHoverActions<cr>", { buffer = bufnr })
        -- 你原来的 lsp-rust.lua 键位放这里
      end },
    }
  end,
}
