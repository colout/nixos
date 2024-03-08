{ pkgs, helpers, ... }:
{
  programs.nixvim = {
    plugins = {
      lualine = {
        enable = true;
      };
    };
  };
}
