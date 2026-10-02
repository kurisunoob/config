return { "akinsho/toggleterm.nvim", config = true,
  keys = {
    {
      "<leader>tf", "<cmd>ToggleTerm<CR>", mode = "n", desc = "Toggle Terminal"
    }
  },
  opts = {
    close_on_exit = true,
    direction = "float",
    float_opts = {
      border = "curved",
      width = 130,
      height = 30,
    },
  }
}
