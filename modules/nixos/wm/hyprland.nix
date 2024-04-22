{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "hyprland";
      gdm = {
        wayland = true;
        enable = true;
      };
    };
  };

  programs.hyprland = {
    package = pkgs.unstable.hyprland;
    enable = true;
    xwayland.enable = true;
  };

  environment = {
    sessionVariables = {
      #WLR_RENDERER_ALLOW_SOFTWARE="1";
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = with pkgs.unstable; [
      waybar
      (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags
          ++ [ "-Dexperimental=true" ]; # workspaces fix
      }))

      swww # wallpaper
      dunst # clipboard
      libnotify
      eww
      rofi-wayland # app launcher
      rofi-emoji
      rofi-top
      rofi-calc
      rofi-power-menu
      hypridle
      hdrop
      jq # for my drop term script

      libsForQt5.qt5.qtwayland
      libsForQt5.qt5ct
      qt5.qtwayland
      qt5.qt5ct
      qt6.qtwayland
      qt6Packages.qt6ct
      glib
      libva

      pavucontrol

      # Themes
      gnome.dconf-editor
    ];
  };

  programs.gamescope = { enable = true; };

  # Desktop portals allow communucation between programs (link/file opening)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  programs.dconf = { enable = true; };

}
