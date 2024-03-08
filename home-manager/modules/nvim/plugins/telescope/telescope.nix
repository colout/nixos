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
        "<C-k>" = "move_selection_previous";
      };
    };

    extensions = {
      fzf-native.enable = true;
    };
  };
}
