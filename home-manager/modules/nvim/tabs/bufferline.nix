{ ... }:

{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      showBufferCloseIcons = false;
      numbers = "none";
      diagnostics = "nvim_lsp";
      #separatorStyle = "slant";
    };
  };
}
