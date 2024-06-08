{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
lib.mkIf true {
  home = {
    packages = with pkgs; [
      autotiling-rs
      cliphist
      dbus
      libnotify
      libcanberra-gtk3
      wf-recorder
      brightnessctl
      pamixer
      slurp
      glib
      grim
      gtk3
      hyprpicker
      swaysome
      wlprop
      wl-clipboard
      wl-screenrec
      wlr-randr
      wtype
      sassc
      satty
      xdg-utils
      ydotool
      wlr-randr
    ];
  };

  systemd.user.targets.hyprland-session.Unit.Wants = ["xdg-desktop-autostart.target"];
  wayland.windowManager.sway = with config.colorscheme.palette; {
    enable = true;
    systemd.enable = true;
    xwayland = true;
    package = inputs.swayfx.packages.${pkgs.system}.default;
  };
}
