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

  programs.swaylock.enable = true;
  services.swayidle.enable = true;
  services.swayosd.enable = true;

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;
    wrapperFeatures.base = true;
  };
}
