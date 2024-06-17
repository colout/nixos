{
  config,
  pkgs,
  ...
}: {
  services.xserver = {videoDrivers = ["nvidia"];};

  boot.initrd.kernelModules = ["nvidia"];
  boot.blacklistedKernelModules = ["nouveau"];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_MaxFramesAllowed = "0";
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      # in https://github.com/lutris/docs/blob/master/InstallingDrivers.md#renderer-configuration-opengl-vulkan
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;

      #package = config.boot.kernelPackages.nvidiaPackages.production;

      package = config.boot.kernelPackages.nvidiaPackages.beta;
      #package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

      #      # Special config to load the latest (535 or 550) driver for the support of the 4070 SUPER
      #      package = let
      #        rcu_patch = pkgs.fetchpatch {
      #          url =
      #            "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
      #          hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
      #        };
      #      in config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #        version = "535.154.05";
      #        sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
      #        sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
      #        openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
      #        settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
      #        persistencedSha256 =
      #          "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";
      #
      #        patches = [ rcu_patch ];
      #      };

      # Use the NVidia open source kernel module (not to be confused with the
      # independent third-party "nouveau" open source driver).
      open = true;
    };
  };

  environment.systemPackages = with pkgs; [vaapiVdpau egl-wayland];

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1"
  ];
}
