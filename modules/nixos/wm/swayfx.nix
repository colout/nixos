{
  config,
  pkgs,
  lib,
  ...
}: let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };
in {
  services = {
    displayManager.defaultSession = "sway";
  };

  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  services.dbus.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      dbus # make dbus-update-activation-environment available in the path
      dbus-sway-environment
      configure-gtk
      wayland
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
