{ config, pkgs, lib, ... }:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    sleep 1
  '';
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "colout";
  home.homeDirectory = "/home/colout";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neovim
    git
    fzf
    gnumake
    gcc
    tree-sitter
    unzip
    cargo
    nodePackages.prettier
    ripgrep
    nodejs
    firefox
    jellyfin-media-player
    vlc
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # hyrland config
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
