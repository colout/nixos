{ pkgs, ... }:

{
  boot = {
    loader = {
      timeout = 12;
      grub = {
        enable = true;
        useOSProber = true;
        #gfxmodeEfi = "1280x720";
        efiSupport = true;
        device = "nodev";
        theme = pkgs.sleek-grub-theme.override {
          #withStyle = "orange";
          withBanner = "欢迎 Xiang Bing";
          # splashImage = ./splash.png;
        };
      };
      efi = { canTouchEfiVariables = true; };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
