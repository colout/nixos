{ pkgs, ... }:

let
  stability-matrix = pkgs.writeShellScriptBin "stability-matrix" ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libxcrypt}/lib
    exec ${pkgs.appimage-run}
  '';

in { environment.systemPackages = [ stability-matrix ]; }
