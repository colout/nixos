{ pkgs, ... }:

let
  stability-matrix = pkgs.writeShellScriptBin "stability-matrix" ''
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${pkgs.libxcrypt}/lib
    export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1
    export DOTNET_SYSTEM_GLOBALIZATION_PREDEFINED_CULTURES_ONLY=false

    echo  $LD_LIBRARY_PATH
    exec ${pkgs.appimage-run}/bin/appimage-rLD_LIBRARY_PATH/libjackun ~/Downloads/StabilityMatrix.AppImage
  '';

in { environment.systemPackages = [ stability-matrix ]; }
