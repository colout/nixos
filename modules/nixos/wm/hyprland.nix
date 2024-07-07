{pkgs, ...}: {
  services = {
    displayManager.defaultSession = "hyprland";
  };

  programs.hyprland = {
    package = pkgs.unstable.hyprland;
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-wlr;
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
        mesonFlags =
          oldAttrs.mesonFlags
          ++ ["-Dexperimental=true"]; # workspaces fix
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
      hyprcursor
      xcur2png
      libsForQt5.qt5.qtwayland
      libsForQt5.qt5ct
      qt6.qtwayland
      qt6Packages.qt6ct
      glib
      libva

      pavucontrol

      # Themes
      gnome.dconf-editor

      # for polkit authentication https://www.reddit.com/r/NixOS/comments/171mexa/polkit_on_hyprland/
      lxqt.lxqt-policykit
    ];
  };

  programs.gamescope = {enable = true;};

  # Desktop portals allow communucation between programs (link/file opening)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  programs.dconf = {enable = true;};
}
