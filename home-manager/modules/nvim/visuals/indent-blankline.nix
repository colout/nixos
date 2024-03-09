{ ... }:

{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      scope.enabled = false;
      indent = {
        highlight = ["CursorColumn" "Whitespace"]; 
        char = "";
      };
      whitespace = {
        highlight = ["CursorColumn" "Whitespace"];
        removeBlanklineTrail = true;
      };
    };
  };
}
