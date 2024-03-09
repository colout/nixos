{ ... }:

{
  programs.nixvim = {
    plugins.indent-blankline = {
      enable = true;
      scope.enabled = true;
      indent = {
        highlight = "Whitespace";
        
        char = "";
      };
    };
  };
}
