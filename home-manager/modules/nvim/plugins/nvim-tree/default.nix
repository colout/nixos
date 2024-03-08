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

        renderer = {
          groupEmpty = true;
          highlightGit = true;
        };

        filters = {
          dotfiles = true;
        };

        view = {
          width = 35;
        };
      };
    };
  };
}
