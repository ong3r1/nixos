return {
  -- Set general options
  opt = {
    relativenumber = true,
    number = true,
  },

  -- Register custom autocommands, keymaps, etc.
  autocmds = require "user.autocmds",

  vim.api.nvim_create_user_command("Format", function() require("conform").format() end, {}),
  -- You can also add mappings or override plugins here too
}
