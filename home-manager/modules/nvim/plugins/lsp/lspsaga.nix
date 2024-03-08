{ ... }:

{
  programs.nixvim.plugins = {
    lspsaga = {
      enable = true;
      lightbulb = {
        enable = true;
        virtualText = false;
      };

      symbolInWinbar.enable = false;
      ui.border = "rounded";
    };
  };
}
