{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoClose = true;
        autoReloadOnWrite = true;
        openOnSetup = true;

        view = {
          width = 35;
        };
      };
    };
  };
}
