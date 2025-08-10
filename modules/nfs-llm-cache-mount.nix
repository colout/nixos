#device = "192.168.10.11:/volume1/llm-models";
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

  # Mount your NAS WITHOUT automount
  fileSystems."/mnt/llm-models" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = [
      "nfsvers=4"
      "fsc" # Still get caching!
      "_netdev"
      "uid=1000"
      "gid=1000"
      # NO automount options
    ];
  };
}
