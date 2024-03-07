{ inputs, pkgs, lib, ... }:
{
    imports = [
      inputs.nixvim.homeManagerModules.nixvim
    ];

    programs.nixvim.enable = true;
}
