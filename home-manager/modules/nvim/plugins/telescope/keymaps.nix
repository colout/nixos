{ pkg, ... }:

{
  programs.nixvim = {
    keymaps = [
      #
      # Plugin Keybinds
      #
      
      # Nvim Tree
      {
        mode = "n";
        key = "<leader>e";
        action = ":NvimTreeToggle<CR>";
      }

      # Telescope fzf
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
      }

    ];
  };
}
