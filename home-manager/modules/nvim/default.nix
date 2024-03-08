{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./visuals
    ./core
    ./plugins
  ];


}
