{ ... }:
{
  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "themes/robbyrussell"; tags = [ as:theme from:oh-my-zsh ]; }
        { name = "plugins/dirhistory"; tags = [ from:oh-my-zsh ]; }
      ];
    };
    shellAliases = {
      ll = "ls -l";
eninie
      # NixOS command shortcuts
      napply = "sudo chown -R $USER /etc/nixos; cd /etc/nixos && git -C /etc/nixos add . && git -C /etc/nixos commit -m 'change'; sudo nixos-rebuild switch --flake /etc/nixos#default";
      nupdate = "nix flake update /etc/nixos";
      nedit = "cd /etc/nixos; nvim";
      ngarbage-collect = "nix-collect-garbage -d";
    };
  };
}
