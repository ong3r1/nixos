{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    extraPlugins = with pkgs.vimPlugins; [
      bufferline-nvim
      nvim-navic
      conform-nvim
      nvim-lint
      gruvbox-nvim
      nvim-autopairs
    ];
    extraConfigLua = ''
      require("config.lint")
      require("config.appearance")
      require("config.fmt")
      require("config.bread-crumbs")
    '';
    colorschemes.gruvbox.enable = true;
    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };
    # Plugins
    plugins = {
      gitsigns.enable = true;
      "nvim-autopairs" = {
        enable = true;
        settings = {
          check_ts = true;
          disable_filetype = ["TelescopePrompt" "vim"];
        };
      };
      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            separator_style = "thin";
            offsets = [
              {
                filetype = "NvimTree";
                text = "File Explorer";
                padding = 1;
              }
            ];
          };
        };
      };
      lualine = {
        enable = true;

        settings = {
          options = {
            # Make separators boxy
            component_separators = {
              left = "▏";
              right = "▕";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
        };
      };
      treesitter = {
        enable = true;
      };
      snacks = {
        enable = true;
        autoLoad = true;
        settings = {
          scroll = {
            enable = true;
          };
          explorer = {
            enable = true;
          };
          picker = {
            enable = true;
          };
        };
      };
      which-key.enable = true;
      trouble.enable = true;
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true; # for faster fuzzy finding
      };
      lazygit.enable = true;
      web-devicons.enable = true;

      # Language Servers
      lsp = {
        enable = true;
        servers = {
          lua_ls.enable = true;
          ts_ls.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          gopls.enable = true;
          sqls.enable = true;
          nixd.enable = true;
        };
        onAttach = ''
          if client.server_capabilities.documentSymbolProvider then
            require("nvim-navic").attach(client, bufnr)
          end
        '';
      };

      # Formatters
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_fallback = true;
            timeout_ms = 500;
          };
          formatters_by_ft = {
            python = ["black" "isort"];
            rust = ["rustfmt"];
            javascript = ["prettier"];
            typescript = ["prettier"];
            typescriptreact = ["prettier"];
            go = ["gofmt" "goimports"];
            sql = ["pg_format"];
            nix = ["alejandra"];
          };
        };
      };
    };

    # Keybindings
    keymaps = [
      {
        key = "<leader>w";
        action = ":w<CR>";
        mode = "n";
        options.desc = "Save file";
      }
      # Buffer management
      {
        mode = "n";
        key = "<leader>bn";
        action = ":BufferLineCycleNext<CR>";
        options = {silent = true;};
      }
      {
        mode = "n";
        key = "<leader>bp";
        action = ":BufferLineCyclePrev<CR>";
        options = {silent = true;};
      }
      {
        mode = "n";
        key = "<leader>bd";
        action = ":bd<CR>";
        options = {silent = true;};
      }
      {
        key = "<leader>q";
        action = ":q<CR>";
        mode = "n";
        options.desc = "Quit neovim";
      }
      {
        key = "<leader>ca";
        action = "vim.lsp.buf.code_action";
        mode = "n";
        lua = true;
        options.desc = "Code action";
      }
      {
        key = "<leader>lf";
        action = ":ConformFormat<CR>";
        mode = "n";
        options.desc = "Format file";
      }
      {
        key = "<leader>xx";
        action = ":TroubleToggle<CR>";
        mode = "n";
        options.desc = "Toggle trouble (diagnostics list)";
      }
      {
        key = "[d";
        action = "vim.diagnostic.goto_prev";
        mode = "n";
        lua = true;
        options.desc = "Previous diagnostic";
      }
      {
        key = "]d";
        action = "vim.diagnostic.goto_next";
        mode = "n";
        lua = true;
        options.desc = "Next diagnostic";
      }
      # Telescope
      {
        key = "<leader>tg";
        action = ":Telescope live_grep<CR>";
        mode = "n";
        options.desc = "Live grep (project-wide search)";
      }
      {
        key = "<leader>tb";
        action = ":Telescope buffers<CR>";
        mode = "n";
        options.desc = "Fuzzy find open buffers";
      }
      {
        key = "<leader>th";
        action = ":Telescope help_tags<CR>";
        mode = "n";
        options.desc = "Fuzzy find help docs";
      }
      {
        key = "<leader>tc";
        action = ":Telescope commands<CR>";
        mode = "n";
        options.desc = "Fuzzy find commands";
      }

      # Reveal file in directory
      {
        mode = "n";
        key = "<leader>e";
        action = "<Cmd>lua require('snacks').explorer.reveal()<CR>";
        options.desc = "Opens file explorer";
      }

      # File picker
      {
        mode = "n";
        key = "<leader>ff";
        action = "<Cmd>lua require('snacks').picker.files()<CR>";
        options.desc = "Opens fuzzy file picker.";
      }

      # lazygit
      {
        key = "<leader>gg";
        action = ":LazyGit<CR>";
        mode = "n";
        options.desc = "Open LazyGit popup";
      }
    ];
  };

  xdg = {
    configFile = {
      "nvim/lua/config/lint.lua".source = ../dotfiles/.config/nvim/lua/config/lint.lua;
      "nvim/lua/config/appearance.lua".source = ../dotfiles/.config/nvim/lua/config/appearance.lua;
      "nvim/lua/config/fmt.lua".source = ../dotfiles/.config/nvim/lua/config/fmt.lua;
      "nvim/lua/config/bread-crumbs.lua".source = ../dotfiles/.config/nvim/lua/config/bread-crumbs.lua;
    };
  };
}
