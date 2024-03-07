{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight = { 
      enable = true;

      style = "storm"; # The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = true; # Enable this to disable setting the background color
      terminal_colors = true; # Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
      styles = {
        # Style to be applied to different syntax groups
        # Value is any valid attr-list value for `:help nvim_set_hl`
        comments = "{ italic = true }";
        keywords = "{ italic = true }";
        functions = "{}";
        variables = "{}";
        # Background styles. Can be "dark"; "transparent" or "normal"
        sidebars = "transparent"; # style for sidebars, see below
        floats = "transparent"; # style for floating windows
      };
    };

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
    plugins.lightline.enable = true;
  };
}
