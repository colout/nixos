{ ... }:

{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      scope.enabled = true;
      indent = {
        highlight = "[\"CursorColumn\", \"Whitespace\"]";
        char = "";
      };
    };
  };
}
