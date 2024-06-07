{
  config,
  pkgs,
  lib,
  ...
}: {
  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
