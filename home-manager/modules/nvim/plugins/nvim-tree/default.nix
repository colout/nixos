{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoClose = true;

        view = {
          width = 35;
        };
      };
    };
  };
}
