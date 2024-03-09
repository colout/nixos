{ ... }:

{
  programs.nixvim = {
    plugins = {
      nvim-tree = {
        enable = true;
        
        autoReloadOnWrite = true;
        openOnSetup = false;
        openOnSetupFile = false;

        updateFocusedFile.enable = true;

        actions = {
          openFile = {
            quitOnOpen = true;
          };
        };

        git = {
          enable = true;
          ignore = false;
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
