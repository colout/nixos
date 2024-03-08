{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoClose = true;
        autoReloadOnWrite = true;
        openOnSetup = true;
        openOnSetupFile = true;

        view = {
          width = 35;
        };
      };
    };
  };
}
