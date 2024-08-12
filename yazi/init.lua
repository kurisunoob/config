require("githead"):setup()
require("full-border"):setup()
require("bookmarks"):setup({
	save_last_directory = false,
	desc_format = "full",
	notify = {
		enable = false,
		timeout = 1,
		message = {
			new = "new bookmark",
		},
	},
})
