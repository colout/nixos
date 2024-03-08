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
        "<C-j>" = "move_selection_next";
        "<C-q>" = "actions.send_selected_to_qflist + actions.open_qflist";
      };
    };

    extensions = {
      fzf-native.enable = true;
    };
  };
}
