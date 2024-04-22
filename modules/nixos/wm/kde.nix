{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
      desktopManager.plasma6.enable = true;
    };
  };

  environment.systemPackages = with pkgs.unstable; [ libsForQt5.ark ];
}
