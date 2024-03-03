{ overlay-stable, overlay-unstable }:
{ config, pkgs, lib, inputs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm = {
      wayland = true;
      enable = true;
    };
  };
  services.xserver.displayManager.defaultSession = "hyprland";

  programs.hyprland = {
    package = pkgs.unstable.hyprland;
    enable = true;
    xwayland.enable = true;
  };

  programs.dconf.enable = true;

  environment = {
    sessionVariables = {
      #WLR_RENDERER_ALLOW_SOFTWARE="1";
      WLR_NO_HARDWARE_CURSORS="1";
      NIXOS_OZONE_WL="1";
    };

    systemPackages = with pkgs.unstable; [
      # Waybar
      waybar
      (pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; # workspaces fix
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
      qt6.qtwayland
      qt6Packages.qt6ct
      glib
      libva

      pavucontrol

      # Themes
      gnome.dconf-editor
      glib # gsettings
      dracula-theme # gtk theme
      gnome3.adwaita-icon-theme  # default gnome cursors
    ];
  };
  
  programs.gamescope = {
    enable = true;
  };

  gtk.enable = true;

  # Desktop portals allow communucation between programs (link/file opening)
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  
}
