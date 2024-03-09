{ ... }:

{
  programs.nixvim = {
      plugins.alpha = let
    logo = [
      "                 .88888888:."
      "                88888888.88888."
      "              .8888888888888888."
      "              888888888888888888"
      "              88' _`88'_  `88888"
      "              88 88 88 88  88888"
      "              88_88_::_88_:88888"
      "              88:::,::,:::::8888"
      "              88`:::::::::'`8888"
      "             .88  `::::'    8:88."
      "            8888            `8:888."
      "          .8888'             `888888."
      "         .8888:..  .::.  ...:'8888888:."
      "        .8888.'     :'     `'::`88:88888"
      "       .8888        '         `.888:8888."
      "      888:8         .           888:88888"
      "    .888:88        .:           888:88888:"
      "    8888888.       ::           88:888888"
      "    `.::.888.      ::          .88888888"
      "   .::::::.888.    ::         :::`8888'.:."
      "  ::::::::::.888   '         .::::::::::::"
      "  ::::::::::::.8    '      .:8::::::::::::."
      " .::::::::::::::.        .:888:::::::::::::"
      " :::::::::::::::88:.__..:88888:::::::::::'"
      "  `'.:::::::::::88888888888.88:::::::::'"
      "        `':::_:' -- '' -'-' `':_::::'`"
    ];
  in {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 1;
      }
      {
        opts = {
          hl = "Constant";
          position = "center";
        };
        type = "text";
        val = logo;
      }
      {
        type = "padding";
        val = 2;
      }
      {
        type = "group";
        val = let
          mkButton = shortcut: cmd: val: hl: {
            type = "button";
            inherit val;
            opts = {
              inherit hl shortcut;
              keymap = [
                "n"
                shortcut
                cmd
                {}
              ];
              position = "center";
              cursor = 0;
              width = 40;
              align_shortcut = "right";
              hl_shortcut = "Keyword";
            };
          };
        in [
          (
            mkButton
            "f"
            "<CMD>lua require('telescope.builtin').find_files({hidden = true})<CR>"
            "🔍 Find File"
            "Operator"
          )
          (
            mkButton
            "q"
            "<CMD>qa<CR>"
            "💣 Quit Neovim"
            "String"
          )
        ];
      }
      {
        type = "padding";
        val = 2;
      }
      {
        opts = {
          position = "center";
        };
        type = "text";
        val = "";
      }
    ];
  };
  };
}
