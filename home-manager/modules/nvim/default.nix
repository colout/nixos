{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./visuals
  ];

  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    keymaps = [
      {
        key = ";";
        action = ":";
      }
      {
        mode = "n";
        key = "x";
        action = "_x";
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = "e:nohl<CR>";
      }

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

    options = {
      # line numbers
      relativenumber = true;
      number = true;

      # tabs
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;

      # some nice defaults
      wrap = false;
      cursorline = true;
      backspace = "indent,eol,start";
      encoding = "utf8";

      # Starts scrolling when closer to bottom
      scrolloff = 8;

      # appearance
      termguicolors = true;
      signcolumn = "yes";

      # Show more info in status bar
      ruler = true;
      showcmd = true;

      # Will implement search incrementally as you type
      incsearch = true;

      # Will hilight all search results
      hlsearch = true;

      # No swap file or temp backup backup before write
      swapfile = false;
      backup = false;
    };

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
