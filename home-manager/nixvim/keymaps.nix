{ ... }: {
  keymaps = [
    {
      mode = "n";
      key = "<leader>w";
      action = ":SessionSave<CR>";
      options.desc = "Save file";
    }
    {
      mode = "n";
      key = "<leader>q";
      action = ":q<CR>";
      options.desc = "Quit";
    }
    {
      mode = "n";
      key = "<leader>?";
      action = "<cmd>lua require('which-key').show({ global = false })<CR>";
      options.desc = "Buffer Local Keymaps (which-key)";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = ":noh<CR>";
      options.desc = "Remove Highlighting";
    }

    # Telescope
    {
      mode = "n";
      key = "<leader>S";
      action = ":Telescope persisted<CR>";
      options.desc = "Restore Session";
    }

    # SNACKS
    # Top Pickers and Explorer
    {
      mode = "n";
      key = "<leader><space>";
      action = "<cmd>lua require(\"snacks\").picker.smart()<CR>";
      options.desc = "Smart Find Files";
    }
    {
      mode = "n";
      key = "<leader>,";
      action = "<cmd>lua require(\"snacks\").picker.buffers()<CR>";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>lua require(\"snacks\").picker.grep()<CR>";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>:";
      action = "<cmd>lua require(\"snacks\").picker.command_history()<CR>";
      options.desc = "Command History";
    }
    {
      mode = "n";
      key = "<leader>n";
      action = "<cmd>lua require(\"snacks\").picker.notifications()<CR>";
      options.desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>lua require(\"snacks\").explorer()<CR>";
      options.desc = "File Explorer";
    }
    # find
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>lua require(\"snacks\").picker.buffers()<CR>";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>fc";
      action = "<cmd>lua require(\"snacks\").picker.files({ cwd = vim.fn.stdpath(\"config\") })<CR>";
      options.desc = "Find Config File";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>lua require(\"snacks\").picker.files()<CR>";
      options.desc = "Find Files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>lua require(\"snacks\").picker.git_files()<CR>";
      options.desc = "Find Git Files";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = "<cmd>lua require(\"snacks\").picker.projects()<CR>";
      options.desc = "Projects";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>lua require(\"snacks\").picker.recent()<CR>";
      options.desc = "Recent";
    }
    # Grep
    {
      mode = "n";
      key = "<leader>sb";
      action = "<cmd>lua require(\"snacks\").picker.lines()<CR>";
      options.desc = "Buffer Lines";
    }
    {
      mode = "n";
      key = "<leader>sB";
      action = "<cmd>lua require(\"snacks\").picker.grep_buffers()<CR>";
      options.desc = "Grep Open Buffers";
    }
    {
      mode = "n";
      key = "<leader>sg";
      action = "<cmd>lua require(\"snacks\").picker.grep()<CR>";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action = "<cmd>lua require(\"snacks\").picker.grep_word()<CR>";
      options.desc = "Visual selection or word";
    }
    # LSP
    {
      mode = "n";
      key = "gd";
      action = "<cmd>lua require(\"snacks\").picker.lsp_definitions()<CR>";
      options.desc = "Goto Definition";
    }
    {
      mode = "n";
      key = "gD";
      action = "<cmd>lua require(\"snacks\").picker.lsp_declarations()<CR>";
      options.desc = "Goto Declaration";
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>lua require(\"snacks\").picker.lsp_references()<CR>";
      options = {
        desc = "References";
        nowait = true;
      };
    }
    {
      mode = "n";
      key = "gI";
      action = "<cmd>lua require(\"snacks\").picker.lsp_implementations()<CR>";
      options.desc = "Goto Implementation";
    }
    {
      mode = "n";
      key = "gy";
      action = "<cmd>lua require(\"snacks\").picker.lsp_type_definitions()<CR>";
      options.desc = "Goto T[y]pe Definition";
    }
    {
      mode = "n";
      key = "gai";
      action = "<cmd>lua require(\"snacks\").picker.lsp_incoming_calls()<CR>";
      options.desc = "C[a]lls Incoming";
    }
    {
      mode = "n";
      key = "gao";
      action = "<cmd>lua require(\"snacks\").picker.lsp_outgoing_calls()<CR>";
      options.desc = "C[a]lls Outgoing";
    }
    {
      mode = "n";
      key = "<leader>ss";
      action = "<cmd>lua require(\"snacks\").picker.lsp_symbols()<CR>";
      options.desc = "LSP Symbols";
    }
    {
      mode = "n";
      key = "<leader>sS";
      action = "<cmd>lua require(\"snacks\").picker.lsp_workspace_symbols()<CR>";
      options.desc = "LSP Workspace Symbols";
    }

    # Diagnostics
    {
      mode = "n";
      key = "<leader>dn";
      action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
      options.desc = "Next Diagnostic";
    }
    {
      mode = "n";
      key = "<leader>dp";
      action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
      options.desc = "Previous Diagnostic";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
      options.desc = "Diagnostics to location list";
    }
    {
      mode = "n";
      key = "<leader>dF";
      action = "<cmd>lua vim.diagnostic.open_float()<CR>";
      options.desc = "Show Diagnostic Float";
    }
    # Other
    {
      mode = "n";
      key = "<leader>z";
      action = "<cmd>lua require(\"snacks\").zen()<CR>";
      options.desc = "Toggle Zen Mode";
    }
    {
      mode = "n";
      key = "<leader>Z";
      action = "<cmd>lua require(\"snacks\").zen.zoom()<CR>";
      options.desc = "Toggle Zoom";
    }
    {
      mode = "n";
      key = "<leader>nh";
      action = "<cmd>lua require(\"snacks\").notifier.show_history()<CR>";
      options.desc = "Notification History";
    }
    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>lua require(\"snacks\").bufdelete()<CR>";
      options.desc = "Delete Buffer";
    }
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>lua require(\"snacks\").lazygit()<CR>";
      options.desc = "Lazygit";
    }
    {
      mode = "n";
      key = "<leader>un";
      action = "<cmd>lua require(\"snacks\").notifier.hide()<CR>";
      options.desc = "Dismiss All Notifications";
    }
    {
      mode = "n";
      key = "<c-_>";
      action = "<cmd>lua require(\"snacks\").terminal()<CR>";
      options.desc = "Toggle Terminal";
    }
  ];
}
