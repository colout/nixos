{pkgs, ...}: {
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
      settings = {general = {renice = 19;};};
    };
  };

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
    protonup-qt
    (lutris.override {
      extraLibraries = pkgs: [
        appimage-run # for rcps3
        fuse

        # from https://github.com/NixOS/nixpkgs/issues/162562#issuecomment-1229444338
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        xorg.libXScrnSaver
        libpng
        libpulseaudio
        libvorbis
        stdenv.cc.cc.lib
        libkrb5
        keyutils # proton-ge-bin
      ];
    })

    dwarf-fortress-packages.dwarf-fortress-full
    superTux
    superTuxKart
    freeciv
    dolphin-emu
    #rpcs3
    xemu

    # for remapping gamepads
    input-remapper
    polkit_gnome # workaround for polkit error with input-remapper
  ];
}
