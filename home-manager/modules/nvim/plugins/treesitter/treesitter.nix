{ ... }:
{
  programs.nixvim.plugins = {
  neiienn
    treesitter = {
      enable = true;
      #folding = true;
      indent = true;
    };
  };
}
