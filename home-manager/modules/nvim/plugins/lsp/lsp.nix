{ ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true;
          marksman.enable = true;
          nil_ls.enable = true;
          pylsp.enable = true;
          yamlls.enable = true;
        };
      };

      # icons in completin
      lspkind = {
        enable = true;
      };

      none-ls = {
        enable = true;
      };

      plugins.luasnip = {
        enable = true;
      };
    };
  };
}
