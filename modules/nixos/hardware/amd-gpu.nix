{
  config,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["amdgpu"];
  hardware.amdgpu.opencl = true;
}
