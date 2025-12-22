{ config, ... }: {
  plugins = {
    telescope = {
      enable = true;
    };
    gitsigns.enable = true;
    web-devicons.enable = true;

    luasnip = {
      enable = true;
    };

    lsp = {
      enable = true;

      capabilities = "require('cmp_nvim_lsp').default_capabilities()";

      servers = {
        lua_ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = [ "vim" ];
              };
              workspace = {
                checkThirdParty = false;
                library = [
                  "\${vim.env.VIMRUNTIME}"
                ];
              };
            };
          };
        };

        ts_ls = {
          enable = true;
          settings = {
            javascript = {
              preferences = {
                importModuleSpecifierPreference = "relative";
              };
            };
            typescript = {
              preferences = {
                importModuleSpecifierPreference = "relative";
              };
            };
          };
        };

        pyright = {
          enable = true;
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic";
                autoSearchPaths = true;
                useLibraryCodeForTypes = true;
              };
            };
          };
        };

        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
          settings = {
            rust-analyzer = {
              cargo = {
                allFeatures = true;
              };
              checkOnSave = {
                command = "clippy";
              };
            };
          };
        };

        gopls = {
          enable = true;
          settings = {
            gopls = {
              analyses = {
                unusedparams = true;
                shadow = true;
              };
              staticcheck = true;
            };
          };
        };
      };
    };

    lspkind = {
      enable = true;
    };

    nvim-autopairs = {
      enable = true;
    };

    which-key = {
      enable = true;
    };

    conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          lua = [ "stylua" ];
          python = [ "isort" "black" ];

          javascript = [ "prettierd" "prettier" ];
          typescript = [ "prettierd" "prettier" ];
          javascriptreact = [ "prettierd" "prettier" ];
          typescriptreact = [ "prettierd" "prettier" ];

          json = [ "prettierd" "prettier" ];
          html = [ "prettierd" "prettier" ];
          css = [ "prettierd" "prettier" ];

          rust = [ "rustfmt" ];
          go = [ "goimports" "gofmt" ];

          nix = [ "nixfmt" "alejandra" "nixpkgs_fmt" ];
        };

        format_on_save = {
          lsp_format = "fallback";
          timeout_ms = 500;
          quiet = true;
        };

        stop_after_first = true;
      };
    };

    snacks = {
      enable = true;

      settings = {
        bigfile = {
          enabled = true;
        };
        explorer = {
          enabled = true;
        };
        indent = {
          enabled = true;
        };
        input = {
          enabled = true;
        };

        notifier = {
          enabled = true;
          timeout = 3000;
        };

        lazygit = {
          enabled = true;
        };
        picker = {
          enabled = true;
        };
        quickfile = {
          enabled = true;
        };
        scope = {
          enabled = true;
        };
        scroll = {
          enabled = false;
        };
        statuscolumn = {
          enabled = true;
        };
        terminal = {
          enabled = true;
        };
        words = {
          enabled = true;
        };

        styles = {
          notification = {
            # wo.wrap = true;
          };
        };
      };
    };

    auto-save = {
      enable = true;
      settings = {
        enabled = true;
        debounce_delay = 1000;
        write_all_buffers = false;
      };
    };

    persisted = {
      enable = true;
      settings = {
        autosave = true;
        autoload = false;
        use_git_branch = true;
        follow_cwd = true;
        ignored_dirs = [
          "$HOME"
          "/tmp"
        ];
        should_autosave = ''
          function()
            return vim.fn.argc() == 0
          end
        '';
        should_autoload = ''
          function()
            return vim.fn.argc() == 0
          end
        '';
      };
    };

    emmet = {
      enable = true;
    };

    cmp = {
      enable = true;
      autoEnableSources = true;

      # sources you want to include
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
          { name = "nvim_lua"; }
          { name = "emmet_vim"; }
        ];
      };
    };
  };
}
