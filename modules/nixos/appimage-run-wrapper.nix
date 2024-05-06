{ pkgs, ... }:

let
  stability-matrix = pkgs.writeShellScriptBin "stability-matrix" ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libxcrypt-legacy}/lib
    export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
    export DOTNET_SYSTEM_GLOBALIZATION_PREDEFINED_CULTURES_ONLY=false

    echo  ${pkgs.cacert}/
    exec ${pkgs.appimage-run}/bin/appimage-run ~/Downloads/StabilityMatrix.AppImage
  '';

in { environment.systemPackages = [ stability-matrix ]; }
