{
  inputs,
  hycov,
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = [
    ./modules/zsh.nix
    ./modules/kitty.nix
    #./modules/nvim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "colout";
  home.homeDirectory = "/home/colout";
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    gcc
    git
    gnumake
    tree-sitter
    unzip
    nodePackages.prettier
    ripgrep
    nodejs
    htop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
