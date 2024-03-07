{ inputs, pkgs, lib, ... }:
{
    imports = [
    # For home-manager
    inputs.nixvim.homeManagerModules.nixvim
    ];
}
