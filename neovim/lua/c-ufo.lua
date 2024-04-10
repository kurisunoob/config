require("ufo").setup({

	vim.keymap.set("n", "zR", require("ufo").openAllFolds),
	vim.keymap.set("n", "zM", require("ufo").closeAllFolds),
	vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds),
	vim.keymap.set("n", "zm", require("ufo").closeFoldsWith), -- closeAllFolds == closeFoldsWith(0),
	vim.keymap.set("n", "zk", require("ufo").peekFoldedLinesUnderCursor),
})
