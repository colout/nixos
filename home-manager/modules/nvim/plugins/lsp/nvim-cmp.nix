{ ... }:
{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;

        # It's annoying to have to `shift+tab` up to what I want to select, these
        # settings stop `cmp` from starting in the middle of the list.
        settings = {
          completion.completeopt = "noselect";
 
          mapping = {
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };

          snippet.expand = "luasnip";
          preselect = "None";
        };

     };
    };

    # I keep accidentally pressing `q` which prevents `cmp` from working because
    # of the macro recording. I don't use this anyway.
    keymaps = [
      {
        mode = "n";
        key = "q";
        action = "<Nop>";
      }
    ];
  };
}
