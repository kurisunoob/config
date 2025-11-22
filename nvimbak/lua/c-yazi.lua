require("yazi").setup({
	event = "VeryLazy",
  open_for_directories=true,
  keys={
    {
      '<leader>e',"<cmd>Yazi<cr>",desc="Open the file manager in nvim's working directory"
    },
  },
})
