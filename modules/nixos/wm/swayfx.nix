{pkgs, ...}: {
  programs.swayfx-unwrapped = {
    package = pkgs.unstable.swayfx-unwrapped;
    enable = true;
  };
}
