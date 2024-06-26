{ pkgs, ... }: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };

    gamemode = {
      enable = true;
      enableRenice = true;
      settings = { general = { renice = 19; }; };
    };
  };

  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    (wineWowPackages.waylandFull.override {
      #wineRelease = "staging";
      wineRelease = "unstable";
      mingwSupport = true;
    })
    bottles

    mangohud
    winetricks
    discord
    appimage-run
    (lutris.override {
      extraLibraries = pkgs: [
        appimage-run # for rcps3
        fuse
      ];
    })

    dwarf-fortress-packages.dwarf-fortress-full
    superTux
    superTuxKart
    freeciv
    dolphin-emu
    #rpcs3
    xemu
  ];
}
