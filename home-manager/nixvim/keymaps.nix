{ ... }:

{
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
{
          mode = "n";
          key = "<leader>?";
          action = "<cmd>lua require('which-key').show({ global = false })<CR>";
          options.desc = "Buffer Local Keymaps (which-key)";
        }
  ];
}
