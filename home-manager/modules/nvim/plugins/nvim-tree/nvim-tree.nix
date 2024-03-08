{ pkg, ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoReloadOnWrite = true;
        openOnSetup = false;
        openOnSetupFile = false;

        actions = {
          openFile = {
            quitOnOpen = true;
          };
        };

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
