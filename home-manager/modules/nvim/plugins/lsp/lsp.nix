{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          lua-ls.enable = true; # lua
          marksman.enable = true; # markdown
          nil_ls.enable = true; # nix
          pylsp.enable = true; # python
          yamlls.enable = true; # yaml
          jsonls.enable = true; # json
        };
      };

      # icons in completion
      lspkind = { enable = true; };

      # null-ls is dead. Lets telescope and other plugins use LSP
      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            statix.enable = true;
            cppcheck.enable = true;
          };
          formatting = {
            clang_format.enable = true;
            cmake_format.enable = true;
            fantomas.enable = true;
            yamlfmt.enable = true;
            gofmt.enable = true;
            goimports.enable = true;
            ktlint.enable = true;
            nixfmt.enable = true;
            markdownlint.enable = true;
          };
          completion = {
            spell.enable = true;
            luasnip.enable = true;
            tags.enable = true;
          };
        };
      };

      # multiline lsp errors
      lsp-lines = { enable = true; };

      # basic snips
      luasnip = { enable = true; };

      # formats on save
      lsp-format = { enable = true; };
    };
  };
}
