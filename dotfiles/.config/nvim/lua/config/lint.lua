-- lua/config/lint.lua

local lint = require("lint")

lint.linters_by_ft = {
  python = { "ruff" },
  go = { "golangci_lint" },
  rust = { "clippy" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  sql = { "sqlcheck" },
}

-- Automatically lint on save and mode change
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "BufEnter" }, {
  callback = function()
    lint.try_lint()
  end,
})
