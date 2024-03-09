{ ... }:

{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      scope.enabled = false;
      indent = {
        #highlight = ["Whitespace" "CursorColumn"]; 
        #char = "";
      };
      whitespace = {
        #highlight = ["Whitespace" "CursorColumn"];
        #removeBlanklineTrail = true;
      };
    };
  };
}
