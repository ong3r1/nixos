{ ... }: {
  opts = {
    number = true;
    clipboard = "unnamedplus";
    relativenumber = true;
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    autoindent = true;
    smartindent = true;
    colorcolumn = "81";
    background = "dark"; # or "light" for light mode
    wrap = false;
    cursorline = true;

    # Enable persistent undo
    undofile = true;

    # Set where undo files are stored
    # Using __raw ensures Lua handles the path expansion correctly
    undodir = { __raw = "vim.fs.normalize('~/.local/share/nvim/undo')"; };

    # How many levels of undo to keep
    undolevels = 10000;
    undoreload = 10000;
  };
}
