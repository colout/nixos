{
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];

  hardware = {
    graphics = {
      # in https://github.com/lutris/docs/blob/master/InstallingDrivers.md#renderer-configuration-opengl-vulkan
      extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
      enable = true;

      enable32Bit = true;
    };
}
