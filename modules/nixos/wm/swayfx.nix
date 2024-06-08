{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      swaylock
      swayidle
      xwayland
      mako
      kanshi
      grim
      slurp
      wl-clipboard
      wf-recorder
      (python38.withPackages (ps: with ps; [i3pystatus keyring]))
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };
}
