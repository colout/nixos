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
    # NixOS automatically adds "dir /var/cache/fscache" line
    # Percentages must follow: bstop < bcull < brun < 100%
    # When free space drops below 7%, culling starts
    # Culling stops when 10% is available again
    # No new cache allocation below 3%
    extraConfig = ''
      brun 10%
      bcull 7%
      bstop 3%
      frun 10%
      fcull 7%
      fstop 3%
    '';
  };

  # Create cache directory and symlink for convenience
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
    "L+ /mnt/nas-models - - - - /mnt/nas_models"
  ];

  # Mount your NAS with caching enabled
  # IMPORTANT: Using underscore instead of hyphen in path to avoid systemd
  # mount unit naming issues where hyphens need \x2d escaping
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
}
