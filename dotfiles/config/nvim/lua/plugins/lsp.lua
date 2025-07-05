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
    },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for server, server_opts in pairs(opts.servers) do
        server_opts.capabilities = capabilities
        lspconfig[server].setup(server_opts)
      end
    end,
  },
}

