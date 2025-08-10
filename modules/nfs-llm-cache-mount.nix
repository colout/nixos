# /etc/nixos/nas-cache.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable NFS support
  boot.supportedFilesystems = ["nfs"];
  services.rpcbind.enable = true;

  # Enable cachefilesd for local caching
  services.cachefilesd = {
    enable = true;
    # Use absolute values instead of percentages
    # With ~900GB total and wanting ~200GB cache
    extraConfig = ''
      dir /var/cache/fscache
      brun 204800
      bcull 153600
      bstop 102400
      frun 10%
      fcull 7%
      fstop 3%
    '';
  };

  # Create cache directory
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
  ];

  # Mount your NAS with caching enabled
  # Changed path to avoid hyphen issues with systemd
  fileSystems."/mnt/nas_models" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = [
      "nfsvers=4"
      "fsc"
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "noatime" # Added for better performance
      "nodiratime"
    ];
  };

  # Create symlink for convenience if you prefer the hyphenated name
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
    "L+ /mnt/nas-models - - - - /mnt/nas_models"
  ];
}
