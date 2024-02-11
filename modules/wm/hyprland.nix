{ config, pkgs, lib, inputs, ... }:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };

  environment = {
    sessionVariables = {
      WLR_RENDERER_ALLOW_SOFTWARE="1";
      WLR_NO_HARDWARE_CURSORS="1";
    };
    systemPackages = with pkgs; [
      # Waybar
      (pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; # workspaces fix
      }))
      dunst # clipboard
      libnotify
      alacritty
      rofi-wayland # app launcher
    ];
  };
    

#  environment = {
#    sessionVariables = {
#      # Hint electron apps to use wayland
#      NIXOS_OZONE_WL = "1";
#    };
#    
#    systemPackages = with pkgs; [
#      # Waybar
#      (pkgs.waybar.overrideAttrs (oldAttrs: {
#          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ]; # workspaces display fix
#        })
#      )
#
#      dunst
#      libnotify
#      alacritty
#      rofi-wayland # app launcher
#    ];
#  };
#
#  programs.hyprland = {
#    enable = true;
#    xwayland.enable = true;
#  };
#
#  # Desktop portals allow communucation between programs (link/file opening)
#  xdg.portal.enable = true;
#  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
#


}
