# /etc/nixos/modules/nfs-llm-cache-mount.nix
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

  # Create cache directory AND symlink in ONE definition
  systemd.tmpfiles.rules = [
    "d /var/cache/fscache 0700 root root -"
    "L /mnt/llm-models - - - - /mnt/llmmodels"
  ];

  # Mount without dash in the actual mount point
  fileSystems."/mnt/llmmodels" = {
    device = "YOUR_NAS_IP:/path/to/models"; # CHANGE THIS!
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
}
