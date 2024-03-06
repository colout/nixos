{ ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      # Tokyo Night color scheme for kitty terminal emulator
      # https://github.com/davidmathers/tokyo-night-kitty-theme
      #
      # Based on Tokyo Night color theme for Visual Studio Code
      # https://github.com/enkia/tokyo-night-vscode-theme

      "foreground" = "#a9b1d6";
      "background" = "#1a1b26";

      # Black
      "color0" = "#414868";
      "color8" = "#414868";

      # Red
      "color1" = "#f7768e";
      "color9" = "#f7768e";

      # Green
      "color2 " = "#73daca";
      "color10" = "#73daca";

      # Yellow
      "color3" = "#e0af68";
      "color11" = "#e0af68";

      # Blue
      "color4 " = "#7aa2f7";
      "color12" = "#7aa2f7";

      # Magenta
      "color5" = "#bb9af7";
      "color13" = "#bb9af7";

      # Cyan
      "color6" = "#7dcfff";
      "color14" = "#7dcfff";

      # White
      "color7 " = "#c0caf5";
      "color15" = "#c0caf5";

      # Cursor
      "cursor" = "#c0caf5";
      "cursor_text_color" = "#1a1b26";

      # Selection highlight
      "selection_foreground" = "none";
      "selection_background" = "#28344a";

      # The color for highlighting URLs on mouse-over
      "url_color" = "#9ece6a";
       background_opacity = ".6";
    };
  };
}
