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
    extraConfig = ''
      dir /var/cache/fscache

      brun 25%
      bcull 30%
      bstop 20%

      frun 10%
      fcull 15%
      fstop 5%
    '';
  };

  # Create cache directory
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
  ];

  # Mount your NAS with caching enabled - using simpler path
  fileSystems."/mnt/llmmodels" = {
    # No dash in the path
    device = "YOUR_NAS_IP:/path/to/models";
    fsType = "nfs";
    options = [
      "nfsvers=4"
      "fsc"
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
      "uid=1000"
      "gid=1000"
    ];
  };

  # Optional: Create a symlink to your preferred name
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
    "L /mnt/llm-models - - - - /mnt/llmmodels"
  ];
}
