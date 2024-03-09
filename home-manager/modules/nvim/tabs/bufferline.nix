{ ... }:

{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      numbers = "none";
      diagnostics = "nvim_lsp";
      separatorStyle = "slope";
    };
  };
}
