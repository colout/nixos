{ ... }:

{
  programs.nixvim = {

    keymaps = [
      {
        mode = "n";
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<CR>";
        options.desc = "Toggle Undotree";
      }
    ];
  };
}
