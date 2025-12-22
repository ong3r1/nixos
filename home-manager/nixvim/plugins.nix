{ ... }:

{
  plugins = {
    telescope.enable = true;
    gitsigns.enable = true;
    web-devicons.enable = true;

    luasnip = {
      enable = true;
    };

    lsp = {
      enable = true;
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
    };

    snacks = {
      enable = true;

      settings = {
        bigfile.enabled = true;
        dashboard.enabled = true;
        explorer.enabled = true;
        indent.enabled = true;
        input.enabled = true;
    
        notifier = {
          enabled = true;
          timeout = 3000;
        };
    
        picker.enabled = true;
        quickfile.enabled = true;
        scope.enabled = true;
        scroll.enabled = false;
        statuscolumn.enabled = true;
        words.enabled = true;
    
        styles = {
          notification = {
            # wo.wrap = true;
          };
        };
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
