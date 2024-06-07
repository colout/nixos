{
  config,
  pkgs,
  lib,
  ...
}: {
  services.dbus.enable = true;

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
