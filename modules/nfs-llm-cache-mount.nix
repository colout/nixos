{
  config,
  lib,
  pkgs,
  ...
}: {
  # Install required packages
  environment.systemPackages = with pkgs; [
    rclone
    nfs-utils
  ];

  # Ensure mount directories exist
  system.activationScripts.rcloneDirs = ''
    mkdir -p /mnt/llm-models
    mkdir -p /mnt/nfs-llm-models
    mkdir -p /var/cache/rclone-vfs
  '';

  # Mount the NFS share first
  fileSystems."/mnt/nfs-llm-models" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = [
      "rw"
      "hard"
      "intr"
      "rsize=131072"
      "wsize=131072"
      "timeo=600"
      "retrans=2"
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=600"
    ];
  };

  # Create rclone configuration
  environment.etc."rclone/rclone.conf".text = ''
    [llm-models-local]
    type = local
    nounc = true
  '';

  # Create systemd service for rclone mount with VFS cache
  systemd.services.rclone-llm-models = {
    description = "Rclone mount for LLM models with VFS cache";
    after = ["network-online.target" "mnt-nfs\\x2dllm\\x2dmodels.mount"];
    wants = ["network-online.target" "mnt-nfs\\x2dllm\\x2dmodels.mount"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "notify";
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 2"; # Small delay to ensure NFS is ready
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount llm-models-local:/mnt/nfs-llm-models /mnt/llm-models \
          --config=/etc/rclone/rclone.conf \
          --vfs-cache-mode=full \
          --vfs-cache-max-size=200G \
          --vfs-cache-max-age=720h \
          --vfs-cache-poll-interval=1m \
          --cache-dir=/var/cache/rclone-vfs \
          --vfs-read-chunk-size=128M \
          --vfs-read-chunk-size-limit=2G \
          --buffer-size=128M \
          --vfs-read-ahead=512M \
          --vfs-write-back=5s \
          --transfers=8 \
          --dir-cache-time=1h \
          --vfs-fast-fingerprint \
          --allow-other \
          --default-permissions \
          --uid=0 \
          --gid=0 \
          --umask=022 \
          --log-level=INFO \
          --log-file=/var/log/rclone-llm-models.log
      '';
      ExecStop = "${pkgs.fuse}/bin/fusermount -u /mnt/llm-models";
      Restart = "on-failure";
      RestartSec = "10s";

      # Run as root for system mount
      User = "root";
      Group = "root";

      # Security settings
      PrivateTmp = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      ReadWritePaths = ["/mnt/llm-models" "/var/cache/rclone-vfs" "/var/log"];
      NoNewPrivileges = true;
    };
  };

  # Optional: Create a systemd timer to periodically clean old cache
  systemd.services.rclone-cache-cleanup = {
    description = "Clean old rclone VFS cache";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.findutils}/bin/find /var/cache/rclone-vfs -type f -atime +30 -delete";
      User = "root";
    };
  };

  systemd.timers.rclone-cache-cleanup = {
    description = "Timer for rclone cache cleanup";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };
}
