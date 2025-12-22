{ ... }:

{
  programs.nixvim.keymaps = [
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
}
