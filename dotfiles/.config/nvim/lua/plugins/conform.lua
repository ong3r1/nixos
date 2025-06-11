return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" }, -- hook before saving
  config = function()
    require("conform").setup {
      format_on_save = {
        lsp_fallback = true, -- uses LSP if no formatter found
        timeout_ms = 1000,
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        sql = { "pg_format" }, -- Or "sqlfluff" if you get it working
      },
      formatters = {
        pg_format = {
          command = "pg_format",
          args = { "-" },
          stdin = true,
        },
      },
    }
  end,
}
