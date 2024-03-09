{ ... }:

{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      showCloseIcon = false;
      numbers = "none";
      diagnostics = "nvim_lsp";
      separatorStyle = "thin";
    };
  };
}
