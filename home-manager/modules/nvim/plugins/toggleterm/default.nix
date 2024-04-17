{ ... }:

{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      #openMapping = "<C-t>"; # deprecated
      direction = "horizontal";
    };
  };
}
