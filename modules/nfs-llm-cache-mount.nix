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
      # Start culling when free space drops to 25% (~228GB)
      brun 30%   # Resume caching when 30% free space available
      bcull 25%  # Start culling when free space drops to 25%
      bstop 20%  # Stop allocating when free space drops to 20%

      # File percentage limits
      frun 15%   # Resume when 15% files available
      fcull 10%  # Start culling when files drop to 10%
      fstop 5%   # Stop allocating when files drop to 5%
    '';
  };

  # Create cache directory
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
  ];

  # Mount your NAS with caching enabled
  fileSystems."/mnt/llm-models" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = [
      "nfsvers=4" # Use NFSv4
      "fsc" # Enable FS-Cache (this is the key!)
      "_netdev" # Network mount
      "x-systemd.automount" # Mount on first access
      "x-systemd.idle-timeout=600" # Unmount after 10 min idle
      "uid=1000"
      "gid=1000"
    ];
  };
}
