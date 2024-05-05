{ pkgs, ... }:

let
  stability-matrix = pkgs.writeShellScriptBin "stability-matrix" ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libxcrypt}/lib
    exec ${pkgs.appimage-run}/bin/appimage-run ~/Downloads/StabilityMatrix.AppImage
  '';

in { environment.systemPackages = [ stability-matrix ]; }
