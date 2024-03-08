{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      vim-cmp = {
        enable = true;

        # It's annoying to have to `shift+tab` up to what I want to select, these
        # settings stop `cmp` from starting in the middle of the list.
        completion.completeopt = "noselect";
        
        mapping = {
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };
      };
    };
  };
}
