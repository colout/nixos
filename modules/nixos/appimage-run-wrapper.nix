{ pkgs, ... }:

let
  ar = pkgs.writeShellScriptBin "ar" ''
    echo ${1}
  '';

in {
  environment.systemPackages = [ ar ];
}
