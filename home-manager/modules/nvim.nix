{ inputs, pkgs, lib, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;

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
      {
        mode = "n";
        key = "<leader>";
        action = "_x";
      }
    ];
  };

  options = {
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;


-- line numbers
    relativenumber = true
    number = true

-- tabs
    tabstop = 2
    shiftwidth = 2
    expandtab = true
    autoindent = true

-- some nice defaults
    wrap = false
    cursorline = true --meh?
    backspace = "indent,eol,start"
    encoding = "utf8"

-- Starts scrolling when closer to bottom
    scrolloff = 8

-- appearance
    termguicolors = true
    signcolumn = "yes"

-- Show more info in status bar
    ruler = true
    showcmd = true

-- Will implement search incrementally as you type
    incsearch = true

-- Will hilight all search results
    hlsearch = true

-- No swap file or temp backup backup before write
    swapfile = false
    backup = false
  };

  programs.nixvim = {
    plugins.lightline.enable = true;
  };
}
