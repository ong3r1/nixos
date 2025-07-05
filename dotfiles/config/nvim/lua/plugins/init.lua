return {
  -- colour scheme
{
  "RRethy/base16-nvim",
  priority = 1000, -- load before other plugins
},

  -- autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  -- fmt
  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  -- lazygit
  -- conform
  {
    'stevearc/conform.nvim',
    opts = {},
  },
  -- lint
  -- telescope
  -- devicons
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      default = true,
    }
  },
  -- lsp
  -- treesitter
}
