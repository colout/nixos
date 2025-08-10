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
    # Simple percentage-based cache management
    # With 400GB free, this gives you ~200GB cache before culling
    extraConfig = ''
      dir /var/cache/fscache

      # Start culling when free space drops to 25% (~228GB)
      brun 25%
      bcull 30%
      bstop 20%

      # File percentage limits
      frun 10%
      fcull 15%
      fstop 5%
    '';
  };

  # Create cache directory
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
  ];

  # Mount your NAS with caching enabled
  fileSystems."/mnt/llmmodels" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = [
      "nfsvers=4" # Use NFSv4
      "fsc" # Enable FS-Cache (this is the key!)
      "_netdev" # Network mount
      "x-systemd.automount" # Mount on first access
      "x-systemd.idle-timeout=600" # Unmount after 10 min idle
      "sec=sys"
    ];
  };
}
