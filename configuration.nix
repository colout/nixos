{ config, pkgs, inputs, outputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Enable overlays 
  nixpkgs.overlays = [ outputs.overlay-stable outputs.overlay-unstable ];

  # Kernel
  #boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelPackages = pkgs.stable.linuxPackages_latest;


  # Bootloader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  boot = {
    loader = {
      timeout = 12;
      grub = {
        enable = true;
        useOSProber = true;
        gfxmodeEfi = "1280x720";
        efiSupport = true;
        device = "nodev";
        theme = pkgs.sleek-grub-theme;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [ "ntfs" ];
  };


  networking.hostName = "nixos"; # Define your hostname.

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

  nix.settings.experimental-features = ["nix-command" "flakes"];


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
    ## sound dies randomly when buffer too short
    #extraConfig.pipewire = {
    #  "92-low-latency" = {
    #    "context.properties" = {
    #      "default.clock.rate" = "48000";
    #      "default.clock.quantum" = "1024";
    #      "default.clock.min-quantum" = "1024";
    #      "default.clock.max-quantum" = "1024";
    #    };
    #  };
    #};
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.colout = {
    isNormalUser = true;
    description = "colout";
    extraGroups = [ "networkmanager" "wheel" "storage" ];
    shell = pkgs.zsh;
  };

  home-manager =  {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "colout" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    wget
    ksystemlog
    zsh
    autofs5
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
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
      };
    };
  };

  home-manager = {

   };

  system.stateVersion = "23.11"; # Did you read the comment?

  # For mount.cifs, required unless domain name resolution is not needed.
  # also create /etc/nixos/smb-secrets with:
  #   username=
  #   password=
  fileSystems."/mnt/media" = {
    device = "//192.168.10.10/media";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,rw,uid=1000"];
  };

  # realtime group
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      type = "-";
      item = "nice";
      value = -20;
    }
  ];
}
