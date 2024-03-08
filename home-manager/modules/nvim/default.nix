{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./visuals
    ./core
    ./plugins
  ];
}
