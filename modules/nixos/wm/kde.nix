{pkgs, ...}: {
  # Enable the X11 windowing system.
  services = {
    desktopManager.plasma6.enable = true;

    xserver = {
      enable = true;
      displayManager.gdm.enable = true;

      # Configure keymap in X11
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.gnome.ksshaskpass.out}/bin/esshaskpass";
  environment.systemPackages = with pkgs.unstable; [
    libsForQt5.dolphin
    kdePackages.dolphin
    libsForQt5.dolphin-plugins
    kdePackages.dolphin-plugins
  ];
}
