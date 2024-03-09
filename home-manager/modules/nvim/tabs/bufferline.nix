{ ... }:

{
  programs.nixvim = {
    plugins.bufferline = {
      enable = true;
      showBufferCloseIcons = false;
      numbers = "none";
      alwaysShowBufferline = false;
      diagnostics = "nvim_lsp";
      separatorStyle = "padded_slant";
    };
  };
}
