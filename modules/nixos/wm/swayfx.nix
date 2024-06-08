{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    displayManager.defaultSession = "sway";
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
      export WLR_RENDERER=vulkan
      export WLR_NO_HARDWARE_CURSORS=1
      export XWAYLAND_NO_GLAMOR=1
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
}
