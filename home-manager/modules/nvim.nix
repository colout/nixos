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
      light_style = "day"; # The theme is used when the background is set to light
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
      sidebars = "{ \"qf\", \"help\" }"; # Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      #day_brightness = "0.3"; # Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      #hide_inactive_statusline = false; # Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      #dim_inactive = false; # dims inactive windows
      lualine_bold = false; # When `true`, section headers in the lualine theme will be bold

      # You can override specific color groups to use other groups or a hex color
      # function will be called with a ColorScheme table
      #param colors ColorScheme
      on_colors = "function(colors) end";

      # You can override specific highlights to use other groups or a hex color
      # function will be called with a Highlights and ColorScheme table
      #param highlights Highlights
      #param colors ColorScheme
      on_highlights = "function(highlights, colors) end";
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
