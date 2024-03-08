{ ... }:
{
  programs.nixvim.plugins = {
    treesitter-context = {
      enable = true;
    };

    treesitter = {
      enable = true;
      folding = true;
      indent = true;

      nixvimInjections = true;
    };
  };
}
