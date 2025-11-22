return { "akinsho/toggleterm.nvim", config = true,
  keys = {
    {
      "<leader>tf","<cmd>ToggleTerm<CR>",  mode = "n", desc = "Toggle comment line" }
  },
  opts={
    close_on_exit = true,
    direction = "float",
    float_opts = {
      border = "curved",
      width = 130,
      height = 30,
    },
  }
}
