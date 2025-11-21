vim.keymap.set("n", "<leader>lf", function()
  require("conform").format({
    async = true,
    lsp_fallback = true,
  })
end, { desc = "Format buffer" })
