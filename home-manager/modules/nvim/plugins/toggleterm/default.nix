{ ... }:

{
  programs.nixvim = {
    plugins.toggleterm = {
      enable = true;
      openMapping = "<leader>t";
      direction = "horizontal";
    };
  };
}
