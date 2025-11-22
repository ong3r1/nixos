vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({
		async = true,
		lsp_fallback = true,
	})
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>lg", vim.diagnostic.open_float, { desc = "Show diagnostics" })
