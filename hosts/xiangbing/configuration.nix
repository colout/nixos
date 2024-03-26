{ pkgs, outputs, ... }: {
  # Enable overlays
  nixpkgs.overlays =
    [ outputs.overlays.packages-stable outputs.overlays.packages-unstable ];

  imports = [
    ../../modules/nixos/wm/hyprland.nix
    ../../modules/nixos/games.nix
    ../../modules/nixos/wm/kde.nix
    ../../modules/nixos/hardware/nvidia-drm.nix
    ../../modules/nixos/boot/grub.nix
    #../../modules/nixos/hardware/nvidia-nvk.nix
  ];

  # Kernel
  boot.kernelPackages =
    pkgs.stable.linuxPackages_6_8; # use stable when nvidia drivers get borked
  #boot.kernelPackages = pkgs.unstable.linuxPackages_6_8;

  system.stateVersion = "23.11";

  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  # Auto mount usb
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEMS=="usb", SUBSYSTEM=="block", ENV{ID_FS_USAGE}=="filesystem", RUN{program}+="${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect $devnode /media/usb"
  '';

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;

    package = pkgs.unstable.pipewire;
    # sound dies randomly when buffer too short
    extraConfig.pipewire = {
      "92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = "48000";
          "default.clock.quantum" = "1024";
          "default.clock.min-quantum" = "1024";
          "default.clock.max-quantum" = "1024";
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.colout = {
    isNormalUser = true;
    description = "colout";
    extraGroups = [ "networkmanager" "wheel" "storage" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    ksystemlog
    zsh
    autofs5
    wayvnc
    nix-index
    inotify-tools
    zip
  ];

  console = {
    #packages = [pkgs.terminus_font];
    #font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    };
  };

  fileSystems."/mnt/media" = {
    device = "//192.168.10.10/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts =
        "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in [ "${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000" ];
  };

  # realtime group for gamemode to choose sane values
  security.pam.loginLimits = [{
    domain = "@wheel";
    type = "-";
    item = "nice";
    value = -20;
  }];

  # ntfs
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/mnt/ntfs" = {
    device = "/dev/disk/by-uuid/A21677F91677CD33";
    fsType = "ntfs-3g";
    options = [ "r" "uid=1000" ];
  };
}
