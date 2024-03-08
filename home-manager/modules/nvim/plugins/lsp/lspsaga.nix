{ ... }:

{
  programs.nixvim = {
    plugins = {
      nixsaga = {
        enable = true;
        lightbulb = {
          enable = true;
          virtualText = false;
        };
        symbolInWinbar.enable = false;
        ui.border = "rounded";
      };
    };
  };
}
