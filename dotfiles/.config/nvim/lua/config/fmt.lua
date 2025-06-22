vim.api.nvim_create_user_command("ConformFormat", function(args)
  require("conform").format({
    async = true,
    lsp_fallback = true,
  })
end, { nargs = 0 })
