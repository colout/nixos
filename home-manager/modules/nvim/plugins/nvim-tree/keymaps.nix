{ pkgs, ... }:

{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = ":NvimTreeToggle<CR>";
    }
  ];
}
