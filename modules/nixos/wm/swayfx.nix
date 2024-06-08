{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    displayManager.defaultSession = "sway";
  };

  hardware.opengl.extraPackages = with pkgs; [
    vulkan-validation-layers
  ];
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
      export NIXOS_OZONE_WL=1
    '';
  };
}
