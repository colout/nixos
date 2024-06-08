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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # nvim stuff

    # nvim telescope
    fzf
    fd

    # nvim lsp
    stylua
    nil
    lua-language-server
    luarocks
    clang-tools
    terraform
    alejandra
    pgformatter
    prettierd
    statix
    nixfmt-classic
    gcc
    nodePackages.jsonlint
    sqlfluff
    python3
    julia
    gopls
    go

    # end nvim stuff

    git
    gnumake
    tree-sitter
    unzip
    cargo
    nodePackages.prettier
    ripgrep
    nodejs
    firefox
    jellyfin-media-player
    vlc
    #gimp-with-plugins
    libreoffice-qt
    tor-browser
    audacity
    #krita
    #inkscape
    #darktable
    #kdenlive
    #tilix
    tidal-hifi
    #blender
    #logseq
    #appflowy
    ark
    qmk
    xemu
    p7zip
    kate
    qpwgraph
    wl-clipboard
    #font-manager
    zsh
    thefuck
    cartridges
    nightfox-gtk-theme
    tokyo-night-gtk
    material-cursors
    mc
    floorp
    chromium
    htop
    obsidian
    godot_4
    blender
    vivaldi
    wezterm
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file.".local/share/rofi/themes".source =
    builtins.fetchGit {
      url = "https://github.com/newmanls/rofi-themes-collection.git";
      rev = "5bc150394bf785b2751711e3050ca425c662938e";
    }
    + "/themes";

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      #gtk-theme = "Nightfox-Dusk-BL-LB";
      gtk-theme = "Tokyonight-Dark-BL-LB";
    };
  };

  #  wayland.windowManager.sway = {
  #    checkConfig = false;
  #    enable = true;
  #
  #    wrapperFeatures.gtk = true; # so that gtk works properly
  #    #package = pkgs.swayfx;
  #    config = rec {
  #      modifier = "Mod4";
  #      # Use kitty as default terminal
  #      terminal = "kitty";
  #      startup = [
  #        # Launch Firefox on start
  #        {command = "firefox";}
  #      ];
  #    };
  #  };
}
