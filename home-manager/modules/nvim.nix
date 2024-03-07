{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    keymaps = [
      {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = "e:nohl<CR>";
      }
    ];
  };


  programs.nixvim = {
    plugins.lightline.enable = true;
  };
}
