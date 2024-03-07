{ inputs, pkgs, lib, ... }:
{
    environment.systemModules = [
    (nixvim.legacyPackages."${system}".makeNixvim {
      colorschemes.gruvbox.enable = true;
    })
  ];
}
