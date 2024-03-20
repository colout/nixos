{ pkgs, ... }:

{
  boot = {
    loader = {
      timeout = 12;
      grub = {
        enable = true;
        useOSProber = true;
        gfxmodeEfi = "1280x720";
        efiSupport = true;
        device = "nodev";
        theme = pkgs.sleek-grub-theme;
        splashImage = "/boot/background.png";
      };
      efi = { canTouchEfiVariables = true; };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
