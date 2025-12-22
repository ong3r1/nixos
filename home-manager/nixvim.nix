{ inputs
, pkgs
, ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    # Core editor behavior
    opts = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      wrap = false;
      cursorline = true;
      termguicolors = true;
    };

    # Keymaps (leader = space by default)
    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = ":w<CR>";
        options.desc = "Save file";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
        options.desc = "Quit";
      }
    ];

    # Plugins
    plugins = {
      # Treesitter for syntax highlighting
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          lua_ls.enable = true;
          nil_ls.enable = true; # Nix language server
        };
      };

      # Autocomplete
      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
        };
      };

      # Fuzzy finder
      telescope.enable = true;

      # Git signs in the gutter
      gitsigns.enable = true;
    };

    # Colorscheme
    colorschemes.gruvbox.enable = true;
  };
}
