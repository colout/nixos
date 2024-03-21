{ pkgs, ... }:

{
  boot = {
    loader = {
      timeout = 12;
      grub = {
        enable = true;
        useOSProber = true;
        gfxmodeEfi = "1920x1080";
        efiSupport = true;
        device = "nodev";
        theme = pkgs.sleek-grub-theme.override {
          withStyle = "dark";
          withBanner = "欢迎 Xiang Bing";
        };
      };
      efi = { canTouchEfiVariables = true; };
    };
    supportedFilesystems = [ "ntfs" ];
  };
}
