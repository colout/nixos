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
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernel.sysctl = {
    "vm.max_map_count" = 16777216;
    "fs.file-max" = 524288;
  };

  # Increase memory lock limits for large language models (mlock in llama.cpp)
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "hard";
      item = "memlock";
      value = "unlimited";
    }
    {
      domain = "*";
      type = "soft";
      item = "memlock";
      value = "unlimited";
    }
  ];

  # For iGPU vram increase
  #  https://www.reddit.com/r/LocalLLaMA/comments/1ks6mlc/what_is_tps_of_qwen3_30ba3b_on_igpu_780m/
  boot.kernelParams = [
    "amdgpu.gttsize=131072"
    "ttm.pages_limit=33554432"
    "transparent_hugepage=always"
    "numa_balancing=disable"
    "amd_iommu=off"
    #"ttm.pages_limit=28311552"
    #"ttm.page_pool_size=28311552"
  ];

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

  networking.hostName = "minilab03"; # Define your hostname.
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
    amdgpu_top
    radeontop
    stable.rocmPackages.rocminfo
    python313Packages.huggingface-hub
    python312
    ctranslate2
    git
    fzy
    jq
    btop-rocm
    rocmPackages.rocm-smi
    lm_sensors
    claude-code

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
    lua-language-server

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

  services.ollama = {
    enable = false;
    host = "0.0.0.0";
    environmentVariables = {
      OLLAMA_NEW_ENGINE = "1"; # Enable new engine for performance improvements
      OLLAMA_KEEP_ALIVE = "10m"; # Keep models in memory longer
      OLLAMA_MAX_LOADED_MODELS = "3"; # Allow multiple models to stay in memory
      OLLAMA_NUM_PARALLEL = "2"; # Enable parallel inference
      OLLAMA_MULTIUSER_CACHE = "1"; # Optimize prompt caching for frequent model switching
      OLLAMA_LOAD_TIMEOUT = "10m"; # Allow more time for model loading
      OLLAMA_NOPRUNE = "1"; # Prevent pruning on startup
      OLLAMA_FLASH_ATTENTION = "1"; # Reduce memory bandwidth usage
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
    docker = {
      enable = true;
      daemon.settings = {
        "userns-remap" = "default";
      };
    };

    #podman = {
    #  enable = true;

    #  # Create a `docker` alias for podman, to use it as a drop-in replacement
    #  dockerCompat = true;
    #  dockerSocket.enable = true;

    #  # Required for containers under podman-compose to be able to talk to each other.
    #  defaultNetwork.settings.dns_enabled = true;
    #};
  };

  systemd.services.ollama-docker = {
    description = "Local Ollama - docker";
    enable = true;
    after = ["docker.service" "docker.socket" "network-online.target"];
    wantedBy = ["multi-user.target" "network-online.target"];
    serviceConfig = {
      Type = "idle";
      User = "colout";
      Group = "docker";
      Environment = "PATH=${pkgs.docker}/bin:${pkgs.docker-compose}/bin:/run/current-system/sw/bin";
      ExecStart = ''/run/current-system/sw/bin/docker compose -f /home/colout/git/ollama-docker/docker-compose.yaml up --pull always'';
      ExecStop = ''/run/current-system/sw/bin/docker compose -f /home/colout/git/ollama-docker/docker-compose.yaml down'';
      WorkingDirectory = ''/home/colout/git/ollama-docker/'';
    };
  };

  #systemd.services.local-ai-web-stack = {
  #  description = "Local AI Web Stack - docker";
  #  enable = true;
  #  after = ["docker.service" "docker.socket" "network-online.target"];
  #  wantedBy = ["multi-user.target" "network-online.target"];
  #  serviceConfig = {
  #    Type = "idle";
  #    User = "colout";
  #    Group = "docker";
  #    Environment = "PATH=${pkgs.docker}/bin:${pkgs.docker-compose}/bin:/run/current-system/sw/bin";
  #    ExecStart = ''/run/current-system/sw/bin/docker compose -f /home/colout/git/local-ai-web-stack/docker-compose.yaml up --pull always'';
  #    ExecStop = ''/run/current-system/sw/bin/docker compose -f /home/colout/git/local-ai-web-stack/docker-compose.yaml down'';
  #    WorkingDirectory = ''/home/colout/git/local-ai-web-stack/'';
  #  };
  #};

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      Macs = [
        "hmac-sha2-512"
        "hmac-sha2-256-etm@openssh.com"
        "hmac-sha2-512-etm@openssh.com"
        "umac-128-etm@openssh.com"
      ];
    };
  };

  console = {
    #packages = [pkgs.terminus_font];
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  nix.settings.trusted-users = ["root" "colout"];

  security.sudo.wheelNeedsPassword = false;

  networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

  fileSystems."/mnt/media" = {
    device = "//192.168.10.11/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000"];
  };

  fileSystems."/mnt/llm-models" = {
    device = "//192.168.10.11/llm-models";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000"];
  };
}
