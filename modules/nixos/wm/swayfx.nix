{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
lib.mkIf true {
  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
  wayland.windowManager.sway = with config.colorscheme.palette; {
    enable = true;
    systemd.enable = true;
    xwayland = true;
    package = inputs.swayfx.packages.${pkgs.system}.default;
  };
}
