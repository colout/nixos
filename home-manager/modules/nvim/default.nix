{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./visuals
    ./core
  ];

  programs.nixvim = {

    globals.mapleader = " ";

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

  programs.nixvim = {
    plugins = {
      lightline = {
        enable = true;
      };

      nvim-tree = {
        enable = true;

        view = {
          width = 35;
        };
      };
    };
  };
}
