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
      napply = "sudo chown -R $USER /etc/nixos; cd /etc/nixos && git -C /etc/nixos add . && git -C /etc/nixos commit -m 'change'; sudo nixos-rebuild switch --flake /etc/nixos#default";
      nupdate = "nix flake update /etc/nixos";
      nedit = "cd /etc/nixos; nvim";
      ngarbage-collect = "nix-collect-garbage -d";
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
         active_tab_foreground = "#${config.colorScheme.palette.base00}";
        active_tab_background = "#${config.colorScheme.palette.base0D}";

        foreground = "#${config.colorScheme.palette.base05}";
        background = "#${config.colorScheme.palette.base00}";
        url_color = "#${config.colorScheme.palette.base0E}";

        # terminal8
        color0 = "#${config.colorScheme.palette.base00}"; # black
        color1 = "#${config.colorScheme.palette.base08}"; # red
        color2 = "#${config.colorScheme.palette.base0B}"; # green
        color3 = "#${config.colorScheme.palette.base0A}"; # yellow
        color4 = "#${config.colorScheme.palette.base0D}"; # blue
        color5 = "#${config.colorScheme.palette.base0E}"; # magenta
        color6 = "#${config.colorScheme.palette.base0C}"; # cyan
        color7 = "#${config.colorScheme.palette.base05}"; # white
        # terminal16
        color8 = "#${config.colorScheme.palette.base03}"; # bright black
        color9 = "#${config.colorScheme.palette.base08}"; # bright red
        color10 = "#${config.colorScheme.palette.base0B}"; # bright green
        color11 = "#${config.colorScheme.palette.base0A}"; # bright yellow
        color12 = "#${config.colorScheme.palette.base0D}"; # bright blue
        color13 = "#${config.colorScheme.palette.base0E}"; # bright magenta
        color14 = "#${config.colorScheme.palette.base0C}"; # bright cyan
        color15 = "#${config.colorScheme.palette.base07}"; # bright white

        repaint_delay = "60";
        sync_to_monitor = "yes";
        background_opacity = "1.0";
        background_blur = "1";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        font_family = "Hack Nerd Font Mono";
        bold_font = "auto";
        italic_font = "auto";
        bold_italic_font = "auto";
        font_size = "10.0";
        cursor_shape = "beam";
        cursor_beam_thickness = "0.5";
        cursor_blink_interval = "0.5";
        strip_trailing_spaces = "always";
        update_check_interval = "0"; # dont want to check for updates, nix and such
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
