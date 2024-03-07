{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    # Enable gruvbox
    colorschemes.gruvbox.enable = true;
  };

  programs.nixvim.enable = true;

  programs.nixvim = {
    plugins.lightline.enable = true;
  };
}
