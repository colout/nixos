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
          colors = {
            white = "#ffffff";
            darkestgreen = "#005f00";
            brightgreen = "#afdf00";
            darkestcyan = "#005f5f";
            mediumcyan = "#87dfff";
            darkestblue = "#005f87";
            darkred = "#870000";
            brightred = "#df0000";
            brightorange = "#ff8700";
            gray1 = "#262626";
            gray2 = "#303030";
            gray4 = "#585858";
            gray5 = "#606060";
            gray7 = "#9e9e9e";
            gray10 = "#f0f0f0";
            brightpurple = "#dfafdf";
            darkpurple = "#870087";
          };
        in {
          normal = {
            a = {
              fg = Colors.mediumcyan;
              bg = Colors.darkestblue;
              gui = "bold";
            };

            b = {
              fg = Colors.gray2;
              bg = Colors.mediumcyan;
            };

            c = {
              fg = Colors.gray7;
              bg = Colors.gray2;
            };

          };

          command = {
            a = {
              fg = Colors.brightgreen;
              bg = Colors.darkestgreen;
              gui = "bold";
            };

            b = {
              fg = Colors.gray2;
              bg = Colors.brightgreen;
            };

          };

          insert = {
            a = {
              fg = Colors.darkestcyan;
              bg = Colors.white;
              gui = "bold";
            };

            b = {
              fg = Colors.darkestcyan;
              bg = Colors.mediumcyan;
            };

            c = {
              fg = Colors.mediumcyan;
              bg = Colors.darkestblue;
            };

          };

          visual = {
            a = {
              fg = Colors.brightpurple;
              bg = Colors.darkpurple;
              gui = "bold";
            };

            b = {
              fg = Colors.darkpurple;
              bg = Colors.brightpurple;
            };

          };

          replace = {
            a = {
              fg = Colors.white;
              bg = Colors.brightred;
              gui = "bold" };
            };

          inactive = {
            a = {
              fg = Colors.gray1;
              bg = Colors.gray5;
              gui = "bold";
            };

            b = {
              fg = Colors.gray1;
              bg = Colors.gray5;
            };

            c = {
              bg = Colors.gray1;
              fg = Colors.gray5;
            };
          };
        };
      };
    };
  };
}
