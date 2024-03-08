{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoClose = true;
        autoReloadOnWrite = true;
        openOnSetup = false;
        openOnSetupFile = false;

        view = {
          width = 35;
        };
      };
    };
  };
}
