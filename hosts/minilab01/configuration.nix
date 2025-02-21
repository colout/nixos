# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  localPackages,
  outputs,
  ...
}: {
  # Enable overlays
  nixpkgs.overlays = [
    outputs.overlays.packages-stable
    outputs.overlays.packages-unstable
  ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/hardware/amd-gpu.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  # swap
  swapDevices = [
    {
      device = "/swapfile";
      size = 100 * 1024; # 100GB
    }
  ];

  # Auto mount usb
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media/usb"
  '';

  nix.settings.experimental-features = ["nix-command" "flakes"];

  #boot.kernelPackages = pkgs.stable.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "minilab01"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.colout = {
    isNormalUser = true;
    description = "colout";
    extraGroups = ["networkmanager" "wheel" "storage" "docker"];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    tmux
    wget
    zsh
    nix-index
    zip
    atop
    htop
    stable.rocmPackages.rocminfo
    python314
    ctranslate2

    ## Virtualization
    docker-compose
    docker

    # nvim stuff
    alejandra
    black
    hadolint
    prettierd
    stylua
    sql-formatter
    terraform
    lua51Packages.luarocks
    marksman
    markdownlint-cli
    lazygit
    nil
    yamllint
    yaml-language-server

    # numpy
    ninja
    cargo
    rustc
    libffi
    libffi.dev
    gcc
    python3Packages.cffi
    gcc-unwrapped
  ];

  # Default ollama
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "5m"; # how long to keep model
      OLLAMA_NUM_PARALLEL = "2";
      #OLLAMA_FLASH_ATTENTION = "1"; # disable if things break
    };
  };

  # amd gpu accelerated ollama
  #  services.ollama = {
  #    enable = true;
  #    host = "0.0.0.0";
  #    acceleration = "rocm";
  #    rocmOverrideGfx = "11.0.3";
  #    environmentVariables = {
  #      HCC_AMDGPU_TARGET = "gfx1103"; # used to be necessary, but doesn't seem to anymore
  #      OLLAMA_FLASH_ATTENTION = "1";
  #      HSA_OVERRIDE_GFX_VERSION = "11.0.3";
  #      AMD_SERIALIZE_KERNEL = "3";
  #      HSA_ENABLE_SDMA = "0";
  #    };
  #    package = pkgs.stable.ollama-rocm; # TODO: shouldn't be stable but rocm build temporarily broken it seems
  #  };

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    docker.enable = true;

    #podman = {
    #  enable = true;

    #  # Create a `docker` alias for podman, to use it as a drop-in replacement
    #  dockerCompat = true;
    #  dockerSocket.enable = true;

    #  # Required for containers under podman-compose to be able to talk to each other.
    #  defaultNetwork.settings.dns_enabled = true;
    #};
  };

  systemd.services.local-ai-web-stack = {
    description = "Local AI Web Stack - docker";
    enable = true;
    after = ["docker.service" "docker.socket" "network-online.target"];
    wantedBy = ["multi-user.target" "network-online.target"];
    serviceConfig = {
      Type = "idle";
      User = "colout";
      Group = "docker";
      Environment = "PATH=${pkgs.docker}/bin:${pkgs.docker-compose}/bin:/run/current-system/sw/bin";
      ExecStart = ''/run/current-system/sw/bin/docker compose -f /home/colout/git/local-ai-web-stack/docker-compose.yaml up'';
      ExecStop = ''/run/current-system/sw/bin/docker compose -f /home/colout/git/local-ai-web-stack/docker-compose.yaml down'';
      WorkingDirectory = ''/home/colout/git/local-ai-web-stack/'';
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  console = {
    #packages = [pkgs.terminus_font];
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  system.stateVersion = "24.05"; # Did you read the comment?

  fileSystems."/mnt/media" = {
    device = "//192.168.10.10/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000"];
  };

  nix.settings.trusted-users = ["root" "colout"];

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = false;
}
