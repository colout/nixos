{pkgs, ...}: {
  environment.systemPackages = with pkgs;
    [
      swayfx
    ]
    ++ pkgs.sway.extraPackages;
}
