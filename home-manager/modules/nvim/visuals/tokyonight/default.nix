{ pkg, ... }:

{
  programs.nixvim = {
    colorschemes.tokyonight = { 
      enable = true;

      style = "storm"; # The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      transparent = true; # Enable this to disable setting the background color
      styles = {
        sidebars = "transparent"; # style for sidebars, see below
        floats = "transparent"; # style for floating windows
      };
    };
  };
}
