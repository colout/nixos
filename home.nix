{ inputs, hycov, config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = _: true; 
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
    gimp-with-plugins
    libreoffice-qt
    tor-browser
    audacity
    krita
    inkscape
    darktable
    kdenlive
    tilix
    tidal-hifi
    blender
    logseq
    appflowy
    qmk
    sweethome3d.application
    xemu
    p7zip
    kate
    qpwgraph
    wl-clipboard
    font-manager
    zsh
    thefuck
    cartridges
    nightfox-gtk-theme
    tokyo-night-gtk
    material-cursors
    mc
    floorp
  ];

  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "themes/robbyrussell"; tags = [ as:theme from:oh-my-zsh ]; }
        { name = "plugins/dirhistory"; tags = [ from:oh-my-zsh ]; }
      ];
    };
    shellAliases = {
      ll = "ls -l";

      # NixOS command shortcuts
      napply = "sudo chown -R $USER /etc/nixos; cd /etc/nixos && git -C /etc/nixos add . && git -C /etc/nixos commit -m 'change'; sudo nixos-rebuild switch --flake /etc/nixos";
      nupdate = "nix flake update /etc/nixos";
      nedit = "cd /etc/nixos; nvim";
      ngarbage-collect = "nix-collect-garbage -d";
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
      # Tokyo Night color scheme for kitty terminal emulator
      # https://github.com/davidmathers/tokyo-night-kitty-theme
      #
      # Based on Tokyo Night color theme for Visual Studio Code
      # https://github.com/enkia/tokyo-night-vscode-theme

      "foreground" = "#a9b1d6";
      "background" = "#1a1b26";

      # Black
      "color0" = "#414868";
      "color8" = "#414868";

      # Red
      "color1" = "#f7768e";
      "color9" = "#f7768e";

      # Green
      "color2 " = "#73daca";
      "color10" = "#73daca";

      # Yellow
      "color3" = "#e0af68";
      "color11" = "#e0af68";

      # Blue
      "color4 " = "#7aa2f7";
      "color12" = "#7aa2f7";

      # Magenta
      "color5" = "#bb9af7";
      "color13" = "#bb9af7";

      # Cyan
      "color6" = "#7dcfff";
      "color14" = "#7dcfff";

      # White
      "color7 " = "#c0caf5";
      "color15" = "#c0caf5";

      # Cursor
      "cursor" = "#c0caf5";
      "cursor_text_color" = "#1a1b26";

      # Selection highlight
      "selection_foreground" = "none";
      "selection_background" = "#28344a";

      # The color for highlighting URLs on mouse-over
      "url_color" = "#9ece6a";
       background_opacity = ".6";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  home.file.".local/share/rofi/themes".source = builtins.fetchGit {
    url = "https://github.com/newmanls/rofi-themes-collection.git";
    rev = "5bc150394bf785b2751711e3050ca425c662938e";
  } + "/themes";  

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      #gtk-theme = "Nightfox-Dusk-BL-LB";
      gtk-theme = "Tokyonight-Dark-BL-LB";
    };
  };
}
