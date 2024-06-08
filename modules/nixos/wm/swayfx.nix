{
  pkgs,
  lib,
  ...
}: {
  services.xserver.excludePackages = [pkgs.xterm];

  environment.systemPackages = with pkgs; [
    swaybg
    waybar
    mako
    nwg-launchers
    autotiling
    wayshot
    brightnessctl
  ];

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    package = pkgs.swayfx;
  };
}
