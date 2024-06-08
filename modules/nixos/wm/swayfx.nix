{
  pkgs,
  swayfx,
  ...
}: {
  environment.systemPackages = with pkgs;
    [
      sway
      swayidle
      swaylock
      swaybg
      swaylock-effects
      sway-launcher-desktop
    ]
    ++ pkgs.sway.extraPackages;
}
