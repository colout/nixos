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
    # cachefilesd expects percentage as just numbers (without % sign)
    # or absolute values in blocks/bytes
    extraConfig = ''
      dir /var/cache/fscache
      tag mycache

      # Percentage-based limits (just the number, no % sign)
      brun 25
      bcull 20
      bstop 10

      # File count limits
      frun 10
      fcull 7
      fstop 3
    '';
  };

  # Create cache directory with proper permissions
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
  ];

  # Mount your NAS with caching enabled
  fileSystems."/mnt/nas-models" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = [
      "nfsvers=4" # Use NFSv4
      "fsc" # Enable FS-Cache
      "_netdev" # Network mount
      "x-systemd.automount" # Mount on first access
      "x-systemd.idle-timeout=600" # Unmount after 10 min idle
      "rw" # Read-write access
      "uid=1000" # Set your user's UID here
      "gid=100" # Set your user's GID here
      "nofail" # Don't fail boot if mount fails
    ];
  };

  # Ensure cachefilesd starts after the cache directory exists
  systemd.services.cachefilesd = {
    after = ["systemd-tmpfiles-setup.service"];
    wants = ["systemd-tmpfiles-setup.service"];
  };
}
