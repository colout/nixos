{...}: {
  programs.zsh = {
    enable = true;
    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-completions";}
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-syntax-highlighting";}
        {
          name = "themes/robbyrussell";
          tags = [as:theme from:oh-my-zsh];
        }
        {
          name = "plugins/dirhistory";
          tags = [from:oh-my-zsh];
        }
      ];
    };
    initExtra = "mkdir -p ~/git; git -C ~/git/dotfiles pull; git clone git@github.com:colout/dotfiles.git ~/git/dotfiles";
    shellAliases = {
      ll = "ls -l";

      # NixOS command shortcuts
      napply = "sudo chown -R $USER /etc/nixos; cd /etc/nixos && git -C /etc/nixos add . && git -C /etc/nixos commit -m 'change'; sudo nixos-rebuild switch --flake /etc/nixos";
      nupdate = "cd /etc/nixos; sudo nix flake update";
      nedit = "cd /etc/nixos; nvim";
      ngarbage-collect = "nix-collect-garbage -d";
    };
  };
}
