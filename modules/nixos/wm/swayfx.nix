{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    displayManager.defaultSession = "sway";
  };

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    #    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.dbus.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      xwayland
      wl-clipboard
      wf-recorder
    ];
    #package = pkgs.swayfx;
    extraOptions = ["--unsupported-gpu"];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      #export WLR_RENDERER=vulkan
      export WLR_NO_HARDWARE_CURSORS=1
      #export XWAYLAND_NO_GLAMOR=1
      export NIXOS_OZONE_WL=1

      export XCURSOR_SIZE=24
      export XCURSOR_THEME=phinger-cursors-light
      export HYPRCURSOR_THEME=phinger-cursors-light
      export HYPRCURSOR_SIZE=24
      export QT_QPA_PLATFORMTHEME=qt6ct
      export WLR_DRM_NO_ATOMIC=1 # remove after kernel 6.8
      export LIBVA_DRIVER_NAME=nvidia
      export XDG_SESSION_TYPE=wayland
      export GBM_BACKEND=nvidia-drm
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';
  };
}
