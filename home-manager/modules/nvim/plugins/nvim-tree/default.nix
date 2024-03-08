{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;

        view = {
          width = 35;
        };
      };
    };
  };
}
