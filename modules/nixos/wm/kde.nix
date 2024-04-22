{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.plasma6.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  environment.systemPackages = with pkgs.unstable; [
    libsForQt5.dolphin
    kdePackages.dolphin
    libsForQt5.dolphin-plugins
    kdePackages.dolphin-plugins
  ];
}
