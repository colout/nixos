{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim.enable = true;

  programs.nixvim = {
    plugins.lightline.enable = true;
  };
}
