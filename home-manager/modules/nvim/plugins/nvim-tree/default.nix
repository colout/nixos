{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoClose = true;
        autoReloadOnWrite = true;
        sortBy = "case_sensitive";

        view = {
          width = 35;
        };
      };
    };
  };
}
