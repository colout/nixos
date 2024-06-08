{pkgs, ...}: {
  programs.swayfx = {
    package = pkgs.unstable.swayfx;
    enable = true;
  };
}
