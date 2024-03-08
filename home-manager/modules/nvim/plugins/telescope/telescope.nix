{ pkg, ... }:

{
  programs.nixvim.plugins.telescope = {
    enable = true;
    defaults = {
      file_ignore_patterns = [
        "^.git/"
        "^output/"
        "^target/"
      ];
    };

    defaults.mappings = {
      i = {
        "<C-k>" = {
          action = "move_selection_previous";
          desc = "Move up in selection";
        };
      };
    };

    extensions = {
      fzf-native.enable = true;
    };
  };
}
