{
  config,
  lib,
  pkgs,
  ...
}: {
  services.cachefilesd.enable = true;

  fileSystems."/mnt/llm-models" = {
    device = "192.168.10.11:/volume1/llm-models";
    fsType = "nfs";
    options = ["rw" "_netdev" "fsc"]; # fsc enables cachefilesd
  };
}
