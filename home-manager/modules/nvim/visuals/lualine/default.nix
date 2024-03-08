{ pkgs, helpers, ... }:
{
  programs.nixvim = {
    plugins = {
      lualine = {
        enable = true;

        componentSeparators = {
          left = "";
          right = "";
        };

        sectionSeparators = {
          left = "";
          right = "";
        };

        sections = {
          lualine_c = [
            {
              name = "filename";
              extraConfig = {
                path = 1;
              };
            }
          ];
        };

        theme = let
          in {
          normal = {
            a = {
              fg = colors.mediumcyan;
              bg = colors.darkestblue;
              gui = "bold";
            };

            b = {
              fg = colors.gray2;
              bg = colors.mediumcyan;
            };

            c = {
              fg = colors.gray7;
              bg = colors.gray2;
            };
          };

          command = {
            a = {
              fg = colors.brightgreen;
              bg = colors.darkestgreen;
              gui = "bold";
            };

            b = {
              fg = colors.gray2;
              bg = colors.brightgreen;
            };
          };

          insert = {
            a = {
              fg = colors.darkestcyan;
              bg = colors.white;
              gui = "bold";
            };

            b = {
              fg = colors.darkestcyan;
              bg = colors.mediumcyan;
            };

            c = {
              fg = colors.mediumcyan;
              bg = colors.darkestblue;
            };
          };

          visual = {
            a = {
              fg = colors.brightpurple;
              bg = colors.darkpurple;
              gui = "bold";
            };

            b = {
              fg = colors.darkpurple;
              bg = colors.brightpurple;
            };
          };

          replace = {
            a = {
              fg = colors.white;
              bg = colors.brightred;
              gui = "bold";
            };
          };

          inactive = {
            a = {
              fg = colors.gray1;
              bg = colors.gray5;
              gui = "bold";
            };

            b = {
              fg = colors.gray1;
              bg = colors.gray5;
            };

            c = {
              bg = colors.gray1;
              fg = colors.gray5;
            };
          };
        };
      };
    };
  };
}
