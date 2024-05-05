{ pkgs, ... }:

let
  helloWorld = pkgs.writeShellScriptBin "helloWorld" ''
    echo Hello World
  '';

in {
  environment.systemPackages = [ helloWorld ];
}
