local M = {}

-- Try loading nvim-navic safely
local ok, navic = pcall(require, "nvim-navic")

-- fallback behaviour if navic is missing
if ok and navic then
  M.get_location = function()
    return navic.get_location()
  end
else
  M.get_location = function()
    return ""
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.o.winbar = "%{%v:lua.require('safe-navic').get_location()%}"
  end,
})

return M
