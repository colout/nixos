{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    displayManager.defaultSession = "hyprland";
  };
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock
      swayidle
      xwayland
      wl-clipboard
      wf-recorder
    ];
    package = pkgs.swayfx;
    extraOptions = ["--unsupported-gpu"];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
}
