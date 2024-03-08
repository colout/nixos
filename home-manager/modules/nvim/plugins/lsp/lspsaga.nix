{ ... }:

{
  programs.nixvim.plugins = {
    lspsaga = {
      enable = true;
      lightbulb = {
        enable = true;
        virtualText = true;
      };

      symbolInWinbar.enable = true;
      ui.border = "rounded";
    };
  };
}
