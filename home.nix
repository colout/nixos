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
    kitty
    wl-clipboard
    font-manager
    zsh
    thefuck
    cartridges
    nightfox-gtk-theme
    tokyo-night-gtk
    material-cursors
    mc
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
      napply = "sudo chown -R $USER /etc/nixos; cd /etc/nixos && git -C /etc/nixos add . && git -C /etc/nixos commit -m 'change'; sudo nixos-rebuild switch --flake /etc/nixos#default";
      nupdate = "nix flake update /etc/nixos";
      nedit = "cd /etc/nixos; nvim";
    };
  };
  programs.kitty = {
    enable = true;
    settings = {
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
