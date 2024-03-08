{ ... }:

{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [ 
      {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "x";
        action = "\"_x";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = "e:nohl<CR>";
      }
    ];
  };
}
