return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	lazy = false,
	config = function()
		vim.g.rustaceanvim = {
			server = {
				on_attach = function(client, bufnr) end,
				default_settings = {
					["rust-analyzer"] = {
						check = {
							checkOnSave = { command = "clippy" },
						},
					},
				},
			},
		}
	end,
}
