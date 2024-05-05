{ pkgs, ... }:

let
  ar = pkgs.writeShellScriptBin "ar" ''
    echo Hello World
  '';

in {
  environment.systemPackages = [ ar ];
}
