{ pkgs, ... }:

let
  stability-matrix = pkgs.writeShellScriptBin "stability-matrix" ''
    echo $1
  '';

in {
  environment.systemPackages = [ stability-matrix ];
}
