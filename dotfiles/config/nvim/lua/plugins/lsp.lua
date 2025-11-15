return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        },
        -- Add more language servers here, e.g.:
        -- tsserver = {},
      },
      default_options = {
        -- shared across all servers
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        flags = { debounce_text_changes = 150 },
        on_attach = function(client, bufnr)
          -- attach keymaps etc
          local bufopts = { buffer = bufnr, remap = false }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          -- add more mappings ...
        end,
      },
    },
    config = function(_, opts)
      -- Iterate through each server and apply config
      for server, server_opts in pairs(opts.servers) do
        local merged = vim.tbl_deep_extend("force",
          opts.default_options,
          server_opts
        )
        -- Define the config for this server
        vim.lsp.config(server, merged)
        -- Enable it so it automatically attaches for its filetypes
        vim.lsp.enable(server)
      end
    end,
  },
}

