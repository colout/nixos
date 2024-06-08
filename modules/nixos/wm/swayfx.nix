{
  pkgs,
  swayfx,
  ...
}: {
  programs.swayfx = {
    enable = true;
    package = swayfx.packages.${pkgs.system}.swayfx;
  };
}
