{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swayfx
  ];
}
